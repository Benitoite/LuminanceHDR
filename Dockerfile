FROM kd6kxr/buildqt

#   add the dependencies

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends build-essential locales pkg-config cmake cmake-data libgl1-mesa-dri libgl1-mesa-dev libglu1-mesa-dev autotools-dev libomp-dev git libexiv2-dev libfftw3-dev libtiff5-dev libjpeg-dev libpng-dev libopenexr-dev libgsl-dev libraw-dev liblcms2-dev libboost-all-dev libcfitsio-dev ca-certificates ssl-cert && apt-get clean

#   clone source code, checkout dev branch 

RUN mkdir -p ~/programs && git clone https://github.com/LuminanceHDR/LuminanceHDR.git ~/programs/code-lhdr && cd ~/programs/code-lhdr && git checkout master

#  compile

RUN export QT=/opt/local/Qt && mkdir ~/programs/code-lhdr/build && cd ~/programs/code-lhdr/build && cmake .. -DCMAKE_C_COMPILER="/usr/bin/gcc"       -DCMAKE_CXX_COMPILER="/usr/bin/g++" -DCMAKE_BUILD_TYPE="Release"  -DCMAKE_VERBOSE_MAKEFILE=1 -DCMAKE_CXX_FLAGS=" -O3   -march=x86-64 -std=gnu++11"   -DUPDATE_TRANSLATIONS=1  -DCMAKE_PREFIX_PATH=$(echo $QT/lib/cmake/* | sed -Ee 's$ $;$g')
# RUN cd ~/programs/code-lhdr/build && /usr/lib/qt5/bin/moc /root/programs/code-lhdr/src/TonemappingPanel/TonemappingSettings.h @/root/programs/code-lhdr/build/src/TonemappingPanel/moc_TonemappingSettings.cpp_parameters -o /root/programs/code-lhdr/build/src/TonemappingPanel/moc_TonemappingSettings.cpp && /usr/lib/qt5/bin/moc /root/programs/code-lhdr/src/TonemappingPanel/TonemappingPanel.h @/root/programs/code-lhdr/build/src/TonemappingPanel/moc_TonemappingPanel.cpp_parameters -o /root/programs/code-lhdr/build/src/TonemappingPanel/moc_TonemappingPanel.cpp && /usr/lib/qt5/bin/moc /root/programs/code-lhdr/src/TonemappingPanel/TMOProgressIndicator.h @/root/programs/code-lhdr/build/src/TonemappingPanel/moc_TMOProgressIndicator.cpp_parameters -o /root/programs/code-lhdr/build/src/TonemappingPanel/moc_TMOProgressIndicator.cpp && /usr/lib/qt5/bin/moc /root/programs/code-lhdr/src/TonemappingPanel/SavingParametersDialog.h @/root/programs/code-lhdr/build/src/TonemappingPanel/moc_SavingParametersDialog.cpp_parameters -o /root/programs/code-lhdr/build/src/TonemappingPanel/moc_SavingParametersDialog.cpp && /usr/lib/qt5/bin/moc /root/programs/code-lhdr/src/HdrWizard/HdrWizard.h @/root/programs/code-lhdr/build/src/HdrWizard/moc_HdrWizard.cpp_parameters -o /root/programs/code-lhdr/build/src/HdrWizard/moc_HdrWizard.cpp && /usr/lib/qt5/bin/moc /root/programs/code-lhdr/src/TransplantExif/TransplantExifDialog.h @/root/programs/code-lhdr/build/src/TransplantExif/moc_TransplantExifDialog.cpp_parameters -o /root/programs/code-lhdr/build/src/TransplantExif/moc_TransplantExifDialog.cpp && /usr/lib/qt5/bin/moc /root/programs/code-lhdr/src/HelpBrowser/sctextbrowser.h @/root/programs/code-lhdr/build/src/HelpBrowser/moc_sctextbrowser.cpp_parameters -o /root/programs/code-lhdr/build/src/HelpBrowser/moc_sctextbrowser.cpp && /usr/lib/qt5/bin/moc /root/programs/code-lhdr/src/HelpBrowser/HelpSideBar.h @/root/programs/code-lhdr/build/src/HelpBrowser/moc_HelpSideBar.cpp_parameters -o /root/programs/code-lhdr/build/src/HelpBrowser/moc_HelpSideBar.cpp && /usr/lib/qt5/bin/moc /root/programs/code-lhdr/src/HelpBrowser/helpbrowser.h @/root/programs/code-lhdr/build/src/HelpBrowser/moc_helpbrowser.cpp_parameters -o /root/programs/code-lhdr/build/src/HelpBrowser/moc_helpbrowser.cpp && /usr/lib/qt5/bin/moc /root/programs/code-lhdr/src/Resize/ResizeDialog.h @/root/programs/code-lhdr/build/src/Resize/moc_ResizeDialog.cpp_parameters -o /root/programs/code-lhdr/build/src/Resize/moc_ResizeDialog.cpp && /usr/lib/qt5/bin/moc /root/programs/code-lhdr/src/Projection/ProjectionsDialog.h @/root/programs/code-lhdr/build/src/Projection/moc_ProjectionsDialog.cpp_parameters -o /root/programs/code-lhdr/build/src/Projection/moc_ProjectionsDialog.cpp && /usr/lib/qt5/bin/moc /root/programs/code-lhdr/src/HdrWizard/HdrCreationManager.h @/root/programs/code-lhdr/build/src/HdrWizard/moc_HdrCreationManager.cpp_parameters -o /root/programs/code-lhdr/build/src/HdrWizard/moc_HdrCreationManager.cpp && /usr/lib/qt5/bin/moc /root/programs/code-lhdr/src/Preferences/PreferencesDialog.h @/root/programs/code-lhdr/build/src/Preferences/moc_PreferencesDialog.cpp_parameters -o /root/programs/code-lhdr/build/src/Preferences/moc_PreferencesDialog.cpp && /usr/lib/qt5/bin/moc /root/programs/code-lhdr/src/Core/TMWorker.h @/root/programs/code-lhdr/build/src/Core/moc_TMWorker.cpp_parameters -o /root/programs/code-lhdr/build/src/Core/moc_TMWorker.cpp && /usr/lib/qt5/bin/moc /root/programs/code-lhdr/src/Core/IOWorker.h @/root/programs/code-lhdr/build/src/Core/moc_IOWorker.cpp_parameters -o /root/programs/code-lhdr/build/src/Core/moc_IOWorker.cpp && /usr/lib/qt5/bin/moc /root/programs/code-lhdr/src/BatchTM/BatchTMJob.h @/root/programs/code-lhdr/build/src/BatchTM/moc_BatchTMJob.cpp_parameters -o /root/programs/code-lhdr/build/src/BatchTM/moc_BatchTMJob.cpp && /usr/lib/qt5/bin/moc /root/programs/code-lhdr/src/Alignment/Align.h @/root/programs/code-lhdr/build/src/Alignment/moc_Align.cpp_parameters -o /root/programs/code-lhdr/build/src/Alignment/moc_Align.cpp  && /usr/lib/qt5/bin/moc /root/programs/code-lhdr/src/BatchTM/BatchTMDialog.h @/root/programs/code-lhdr/build/src/BatchTM/moc_BatchTMDialog.cpp_parameters -o /root/programs/code-lhdr/build/src/BatchTM/moc_BatchTMDialog.cpp && /usr/lib/qt5/bin/moc /root/programs/code-lhdr/src/MainWindow/DonationDialog.h @/root/programs/code-lhdr/build/src/MainWindow/moc_DonationDialog.cpp_parameters -o /root/programs/code-lhdr/build/src/MainWindow/moc_DonationDialog.cpp && /usr/lib/qt5/bin/moc /root/programs/code-lhdr/src/PreviewPanel/PreviewLabel.h @/root/programs/code-lhdr/build/src/PreviewPanel/moc_PreviewLabel.cpp_parameters -o /root/programs/code-lhdr/build/src/PreviewPanel/moc_PreviewLabel.cpp && /usr/lib/qt5/bin/moc /root/programs/code-lhdr/src/BatchHDR/BatchHDRDialog.h @/root/programs/code-lhdr/build/src/BatchHDR/moc_BatchHDRDialog.cpp_parameters -o /root/programs/code-lhdr/build/src/BatchHDR/moc_BatchHDRDialog.cpp && /usr/lib/qt5/bin/moc /root/programs/code-lhdr/src/OsIntegration/osintegration.h @/root/programs/code-lhdr/build/src/OsIntegration/moc_osintegration.cpp_parameters -o /root/programs/code-lhdr/build/src/OsIntegration/moc_osintegration.cpp &&  /usr/lib/qt5/bin/moc /root/programs/code-lhdr/src/MainWindow/DnDOption.h @/root/programs/code-lhdr/build/src/MainWindow/moc_DnDOption.cpp_parameters -o /root/programs/code-lhdr/build/src/MainWindow/moc_DnDOption.cpp && /usr/lib/qt5/bin/moc /root/programs/code-lhdr/src/Common/LuminanceOptions.h @/root/programs/code-lhdr/build/src/Common/moc_LuminanceOptions.cpp_parameters -o /root/programs/code-lhdr/build/src/Common/moc_LuminanceOptions.cpp && /usr/lib/qt5/bin/moc /root/programs/code-lhdr/src/Common/ProgressHelper.h @/root/programs/code-lhdr/build/src/Common/moc_ProgressHelper.cpp_parameters -o /root/programs/code-lhdr/build/src/Common/moc_ProgressHelper.cpp && /usr/lib/qt5/bin/moc /root/programs/code-lhdr/src/contrib/qtwaitingspinner/QtWaitingSpinner.h @/root/programs/code-lhdr/build/src/contrib/qtwaitingspinner/moc_QtWaitingSpinner.cpp_parameters -o /root/programs/code-lhdr/build/src/contrib/qtwaitingspinner/moc_QtWaitingSpinner.cpp && /usr/lib/qt5/bin/moc /root/programs/code-lhdr/src/PreviewPanel/PreviewPanel.h @/root/programs/code-lhdr/build/src/PreviewPanel/moc_PreviewPanel.cpp_parameters -o /root/programs/code-lhdr/build/src/PreviewPanel/moc_PreviewPanel.cpp && /usr/lib/qt5/bin/moc /root/programs/code-lhdr/src/MainWindow/UpdateChecker.h @/root/programs/code-lhdr/build/src/MainWindow/moc_UpdateChecker.cpp_parameters -o /root/programs/code-lhdr/build/src/MainWindow/moc_UpdateChecker.cpp && /usr/lib/qt5/bin/moc /root/programs/code-lhdr/src/Common/SavedParametersDialog.h @/root/programs/code-lhdr/build/src/Common/moc_SavedParametersDialog.cpp_parameters -o /root/programs/code-lhdr/build/src/Common/moc_SavedParametersDialog.cpp && /usr/lib/qt5/bin/moc /root/programs/code-lhdr/src/MainWindow/MainWindow.h @/root/programs/code-lhdr/build/src/MainWindow/moc_MainWindow.cpp_parameters -o /root/programs/code-lhdr/build/src/MainWindow/moc_MainWindow.cpp && /usr/lib/qt5/bin/moc /root/programs/code-lhdr/src/LibpfsAdditions/formathelper.h @/root/programs/code-lhdr/build/src/LibpfsAdditions/moc_formathelper.cpp_parameters -o /root/programs/code-lhdr/build/src/LibpfsAdditions/moc_formathelper.cpp && /usr/lib/qt5/bin/moc /root/programs/code-lhdr/src/MainWindow/MainWindow.h @/root/programs/code-lhdr/build/src/MainWindow/moc_MainWindow.cpp_parameters -o /root/programs/code-lhdr/build/src/MainWindow/moc_MainWindow.cpp && /usr/lib/qt5/bin/moc /root/programs/code-lhdr/src/Viewers/PanIconWidget.h @/root/programs/code-lhdr/build/src/Viewers/moc_PanIconWidget.cpp_parameters -o /root/programs/code-lhdr/build/src/Viewers/moc_PanIconWidget.cpp && /usr/lib/qt5/bin/moc /root/programs/code-lhdr/src/Viewers/GenericViewer.h @/root/programs/code-lhdr/build/src/Viewers/moc_GenericViewer.cpp_parameters -o /root/programs/code-lhdr/build/src/Viewers/moc_GenericViewer.cpp && /usr/lib/qt5/bin/moc /root/programs/code-lhdr/src/Viewers/HdrViewer.h @/root/programs/code-lhdr/build/src/Viewers/moc_HdrViewer.cpp_parameters -o /root/programs/code-lhdr/build/src/Viewers/moc_HdrViewer.cpp && /usr/lib/qt5/bin/moc /root/programs/code-lhdr/src/Viewers/LdrViewer.h @/root/programs/code-lhdr/build/src/Viewers/moc_LdrViewer.cpp_parameters -o /root/programs/code-lhdr/build/src/Viewers/moc_LdrViewer.cpp && /usr/lib/qt5/bin/moc /root/programs/code-lhdr/src/Viewers/IGraphicsPixmapItem.h @/root/programs/code-lhdr/build/src/Viewers/moc_IGraphicsPixmapItem.cpp_parameters -o /root/programs/code-lhdr/build/src/Viewers/moc_IGraphicsPixmapItem.cpp && /usr/lib/qt5/bin/moc /root/programs/code-lhdr/src/Viewers/IGraphicsView.h @/root/programs/code-lhdr/build/src/Viewers/moc_IGraphicsView.cpp_parameters -o /root/programs/code-lhdr/build/src/Viewers/moc_IGraphicsView.cpp && /usr/lib/qt5/bin/moc /root/programs/code-lhdr/src/Viewers/LuminanceRangeWidget.h @/root/programs/code-lhdr/build/src/Viewers/moc_LuminanceRangeWidget.cpp_parameters -o /root/programs/code-lhdr/build/src/Viewers/moc_LuminanceRangeWidget.cpp && /usr/lib/qt5/bin/moc /root/programs/code-lhdr/src/UI/TiffModeDialog.h @/root/programs/code-lhdr/build/src/UI/moc_TiffModeDialog.cpp_parameters -o /root/programs/code-lhdr/build/src/UI/moc_TiffModeDialog.cpp && /usr/lib/qt5/bin/moc /root/programs/code-lhdr/src/UI/PreviewFrame.h @/root/programs/code-lhdr/build/src/UI/moc_PreviewFrame.cpp_parameters -o /root/programs/code-lhdr/build/src/UI/moc_PreviewFrame.cpp && /usr/lib/qt5/bin/moc /root/programs/code-lhdr/src/UI/SimplePreviewLabel.h @/root/programs/code-lhdr/build/src/UI/moc_SimplePreviewLabel.cpp_parameters -o /root/programs/code-lhdr/build/src/UI/moc_SimplePreviewLabel.cpp && /usr/lib/qt5/bin/moc /root/programs/code-lhdr/src/UI/UMessageBox.h @/root/programs/code-lhdr/build/src/UI/moc_UMessageBox.cpp_parameters -o /root/programs/code-lhdr/build/src/UI/moc_UMessageBox.cpp && /usr/lib/qt5/bin/moc /root/programs/code-lhdr/src/UI/FlowLayout.h @/root/programs/code-lhdr/build/src/UI/moc_FlowLayout.cpp_parameters -o /root/programs/code-lhdr/build/src/UI/moc_FlowLayout.cpp && /usr/lib/qt5/bin/moc /root/programs/code-lhdr/src/UI/ExportToHtmlDialog.h @/root/programs/code-lhdr/build/src/UI/moc_ExportToHtmlDialog.cpp_parameters -o /root/programs/code-lhdr/build/src/UI/moc_ExportToHtmlDialog.cpp && /usr/lib/qt5/bin/moc /root/programs/code-lhdr/src/UI/SupportedCamerasDialog.h @/root/programs/code-lhdr/build/src/UI/moc_SupportedCamerasDialog.cpp_parameters -o /root/programs/code-lhdr/build/src/UI/moc_SupportedCamerasDialog.cpp && /usr/lib/qt5/bin/moc /root/programs/code-lhdr/src/UI/FitsImporter.h @/root/programs/code-lhdr/build/src/UI/moc_FitsImporter.cpp_parameters -o /root/programs/code-lhdr/build/src/UI/moc_FitsImporter.cpp && /usr/lib/qt5/bin/moc /root/programs/code-lhdr/src/TonemappingPanel/ThresholdWidget.h @/root/programs/code-lhdr/build/src/TonemappingPanel/moc_ThresholdWidget.cpp_parameters -o /root/programs/code-lhdr/build/src/TonemappingPanel/moc_ThresholdWidget.cpp && /usr/lib/qt5/bin/moc /root/programs/code-lhdr/src/UI/ExtWizardPage.h @/root/programs/code-lhdr/build/src/UI/moc_ExtWizardPage.cpp_parameters -o /root/programs/code-lhdr/build/src/UI/moc_ExtWizardPage.cpp && /usr/lib/qt5/bin/moc /root/programs/code-lhdr/src/UI/GammaAndLevels.h @/root/programs/code-lhdr/build/src/UI/moc_GammaAndLevels.cpp_parameters -o /root/programs/code-lhdr/build/src/UI/moc_GammaAndLevels.cpp && /usr/lib/qt5/bin/moc /root/programs/code-lhdr/src/UI/Gang.h @/root/programs/code-lhdr/build/src/UI/moc_Gang.cpp_parameters -o /root/programs/code-lhdr/build/src/UI/moc_Gang.cpp && /usr/lib/qt5/bin/moc /root/programs/code-lhdr/src/UI/ImageQualityDialog.h @/root/programs/code-lhdr/build/src/UI/moc_ImageQualityDialog.cpp_parameters -o /root/programs/code-lhdr/build/src/UI/moc_ImageQualityDialog.cpp && /usr/lib/qt5/bin/moc /root/programs/code-lhdr/src/PreviewSettings/PreviewSettings.h @/root/programs/code-lhdr/build/src/PreviewSettings/moc_PreviewSettings.cpp_parameters -o /root/programs/code-lhdr/build/src/PreviewSettings/moc_PreviewSettings.cpp && /usr/lib/qt5/bin/moc /root/programs/code-lhdr/src/Viewers/HdrViewer.h @/root/programs/code-lhdr/build/src/Viewers/moc_HdrViewer.cpp_parameters -o /root/programs/code-lhdr/build/src/Viewers/moc_HdrViewer.cpp && /usr/lib/qt5/bin/moc /root/programs/code-lhdr/src/HdrWizard/EditingTools.h @/root/programs/code-lhdr/build/src/HdrWizard/moc_EditingTools.cpp_parameters -o /root/programs/code-lhdr/build/src/HdrWizard/moc_EditingTools.cpp && /usr/lib/qt5/bin/moc /root/programs/code-lhdr/src/MainCli/commandline.h @/root/programs/code-lhdr/build/src/MainCli/moc_commandline.cpp_parameters -o /root/programs/code-lhdr/build/src/MainCli/moc_commandline.cpp && /usr/lib/qt5/bin/moc /root/programs/code-lhdr/src/HdrWizard/PreviewWidget.h @/root/programs/code-lhdr/build/src/HdrWizard/moc_PreviewWidget.cpp_parameters -o /root/programs/code-lhdr/build/src/HdrWizard/moc_PreviewWidget.cpp && /usr/lib/qt5/bin/moc /root/programs/code-lhdr/src/HdrWizard/HdrPreview.h @/root/programs/code-lhdr/build/src/HdrWizard/moc_HdrPreview.cpp_parameters -o /root/programs/code-lhdr/build/src/HdrWizard/moc_HdrPreview.cpp && /usr/lib/qt5/bin/moc /root/programs/code-lhdr/src/UI/ExtWizardPage.h @/root/programs/code-lhdr/build/src/UI/moc_ExtWizardPage.cpp_parameters -o /root/programs/code-lhdr/build/src/UI/moc_ExtWizardPage.cpp
RUN cd ~/programs/code-lhdr/build && make -j2 install

#   set entrypoint cmd

LABEL maintainer="kd6kxr@gmail.com"
CMD echo "This is a test..." && /usr/local/bin/luminance-hdr && echo "...THATS ALL FOLKS!!!"

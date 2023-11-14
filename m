Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B03C07EAC09
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 09:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbjKNIt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 03:49:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbjKNItx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 03:49:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92696198
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 00:49:48 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C42BBC433C8;
        Tue, 14 Nov 2023 08:49:45 +0000 (UTC)
Message-ID: <c284b41a-3402-4e86-9331-545f592a6044@xs4all.nl>
Date:   Tue, 14 Nov 2023 09:49:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 4/5] documentation: media: add documentation for
 Toshiba Visconti Video Input Interface driver
Content-Language: en-US, nl
To:     Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231012071329.2542003-1-yuji2.ishikawa@toshiba.co.jp>
 <20231012071329.2542003-5-yuji2.ishikawa@toshiba.co.jp>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Autocrypt: addr=hverkuil@xs4all.nl; keydata=
 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
In-Reply-To: <20231012071329.2542003-5-yuji2.ishikawa@toshiba.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/2023 09:13, Yuji Ishikawa wrote:
> Added basic description of Video Input Interface driver of
> Toshiba Visconti architecture.
> It includes hardware organization, structure of the driver
> and description of vendor specific V4L2 controls
> to configure the embedded image signal processor.
> 
> Signed-off-by: Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
> ---
> Changelog v3:
> - Newly add documentation to describe SW and HW
> 
> Changelog v4:
> - no change
> 
> Changelog v5:
> - no change
> 
> Changelog v6:
> - add description of CSI2RX subdevice
> - add ordering of ioctl(S_FMT) and ioctl(S_EXT_CTRLS)
> 
> Changelog v7:
> - no change
> 
> Changelog v8:
> - add usage of V4L2_CTRL_TYPE_VISCONTI_ISP
> 
> Changelog v9:
> - fix warning: set reference target for keyword V4L2_CTRL_TYPE_VISCONTI_ISP
> 
>  .../driver-api/media/drivers/index.rst        |   1 +
>  .../media/drivers/visconti-viif.rst           | 462 ++++++++++++++++++
>  .../media/v4l/vidioc-g-ext-ctrls.rst          |   4 +
>  .../media/v4l/vidioc-queryctrl.rst            |   5 +
>  .../media/videodev2.h.rst.exceptions          |   1 +
>  5 files changed, 473 insertions(+)
>  create mode 100644 Documentation/driver-api/media/drivers/visconti-viif.rst
> 
> diff --git a/Documentation/driver-api/media/drivers/index.rst b/Documentation/driver-api/media/drivers/index.rst
> index c4123a16b5f9..5592bd99ae5c 100644
> --- a/Documentation/driver-api/media/drivers/index.rst
> +++ b/Documentation/driver-api/media/drivers/index.rst
> @@ -24,6 +24,7 @@ Video4Linux (V4L) drivers
>  	sh_mobile_ceu_camera
>  	tuners
>  	vimc-devel
> +	visconti-viif
>  	zoran
>  	ccs/ccs
>  
> diff --git a/Documentation/driver-api/media/drivers/visconti-viif.rst b/Documentation/driver-api/media/drivers/visconti-viif.rst
> new file mode 100644
> index 000000000000..fd2480cbde46
> --- /dev/null
> +++ b/Documentation/driver-api/media/drivers/visconti-viif.rst
> @@ -0,0 +1,462 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +============================================
> +Visconti Video Input Interface (VIIF) Driver
> +============================================
> +
> +Overview
> +========
> +
> +The Visconti VIIF Hardware
> +--------------------------
> +
> +The Visconti Video Input Interface (VIIF) hardware is  a proprietary videocapture device of Toshiba.
> +Following function modules are integrated:
> +
> +* MIPI CSI2 receiver (CSI2RX)
> +* L1 Image Signal Processor (L1ISP)
> +
> +  * Correction, enhancement, adjustment on RAW pictures.
> +
> +* L2 Image Signal Processor (L2ISP)
> +
> +  * Lens distortion correction
> +  * Scaling
> +  * Cropping
> +
> +* Video DMAC
> +
> +  * format picture (RGB, YUV, Grayscale, ...)
> +  * write picture into DRAM
> +
> +Visconti5 SoC has two VIIF hardware instances.
> +
> +software architecture
> +---------------------
> +
> +The Visconti VIIF driver is composed of following components:
> +
> +* (image sensor driver)
> +* MIPI CSI2 receiver subdevice driver
> +
> +  * corresponding to CSI2RX
> +
> +* Visconti ISP subdevice driver
> +
> +  * corresponding to L1ISP, L2ISP (Lens distortion correction, Scaling)
> +
> +* Visconti Capture V4L2 device driver
> +
> +  * corresponding to L2ISP (Cropping) and Video DMAC
> +  * multiple output videobuf queues
> +
> +    * main path0 (RGB, YUV, Grayscale, ...)
> +    * main path1 (RGB, YUV, Grayscale, ...)
> +    * sub path (RAW picture)
> +
> +::
> +
> +  +-----------+      +-----------+     +----------------+       +-------------------------+
> +  | Sensor    |      | CSI2RX    |     | ISP            |       | Capture MAIN PATH0      |
> +  | subdevice | ---- | subdevice | --- | subdevice      | --+-- | V4L2 device             |
> +  | (IMX219)  |      | (CSI2RX)  |     | (L1ISP, L2ISP) |   |   | (L2ISP crop, VideoDMAC) |
> +  +-----------+      +-----------+     +----------------+   |   +-------------------------+
> +                                                            |
> +                                                            |   +-------------------------+
> +                                                            |   | Capture MAIN PATH1      |
> +                                                            +-- | V4L2 device             |
> +                                                            |   | (L2ISP crop, VideoDMAC) |
> +                                                            |   +-------------------------+
> +                                                            |
> +                                                            |   +-------------------------+
> +                                                            |   | Capture SUB PATH        |
> +                                                            +-- | V4L2 device             |
> +                                                                | (VideoDMAC)             |
> +                                                                +-------------------------+
> +
> +
> +The VIIF driver provides following device nodes for Visconti5 SoC:
> +
> +* VIIF0
> +
> +  * /dev/media0
> +  * /dev/video0 (main path0)
> +  * /dev/video1 (main path1)
> +  * /dev/video2 (sub path)
> +
> +* VIIF1
> +
> +  * /dev/media1
> +  * /dev/video3 (main path0)
> +  * /dev/video4 (main path1)
> +  * /dev/video5 (sub path)
> +
> +Use of coherent memory
> +----------------------
> +
> +Visconti5 SoC has two independent DDR SDRAM controllers.
> +Each controller is mapped to 36bit address space.
> +
> +Accelerator bus masters have two paths to access memory;
> +one is directly connected to SDRAM controller,
> +the another is connected via a cache coherency bus
> +which keeps coherency among CPUs.
> +
> +From acclerators and CPUs, the address map is following:

acclerators -> accelerators

> +
> +* 0x0_8000_0000 DDR0 direct access
> +* 0x4_8000_0000 DDR0 coherency bus
> +* 0x8_8000_0000 DDR1 direct access
> +* 0xC_8000_0000 DDR1 coherency bus
> +
> +The base address can be specified with "memory" and "reserved-memory" elements
> +in a device tree description.
> +It's not recommended to mix direct address and coherent address.
> +
> +The Visconti5 VIIF driver always use only direct address to configure Video DMACs of the hardware.
> +This design is to avoid great performance loss at coherency bus caused by massive memory access.
> +You should not put the dma_coherent attribute to viif element in device tree.
> +Cache operations are done automatically by videobuf2 driver.
> +
> +Tested environment
> +------------------
> +
> +The Visconti VIIF driver was tested with following items:
> +
> +* IMX219 image sensor
> +* IMX335 image sensor
> +
> +IOCTLs
> +======
> +
> +Following public IOCTLs are supported
> +
> +* VIDIOC_QUERYCAP
> +* VIDIOC_ENUM_FMT
> +* VIDIOC_TRY_FMT
> +* VIDIOC_S_FMT
> +* VIDIOC_G_FMT
> +* VIDIOC_ENUM_FRAMESIZES
> +* VIDIOC_G_EXT_CTRLS
> +* VIDIOC_S_EXT_CTRLS
> +* VIDIOC_REQBUFS
> +* VIDIOC_QUERYBUF
> +* VIDIOC_QBUF
> +* VIDIOC_EXPBUF
> +* VIDIOC_DQBUF
> +* VIDIOC_CREATE_BUFS
> +* VIDIOC_PREPARE_BUF
> +* VIDIOC_STREAMON
> +* VIDIOC_STREAMOFF

I would not mention these, this is all standard stuff.

The list is also incomplete :-)

> +
> +Vendor specific v4l2 controls
> +(except for V4L2_CID_VISCONTI_VIIF_MAIN_SET_RAWPACK_MODE and
> +V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_INPUT_MODE) should be called
> +after ioctl(S_FMT) because setting the frame format may affect
> +valid range of parameters of the controls.

What happens if I do this the other way around? I.e., set a control,
then set the format. Will the control values/ranges be updated automatically?
If not, what will happen if I try to stream?

Generally setting the format should modify all affected controls if
they are no longer matching the format requirements.

> +
> +Vendor specific v4l2 controls
> +=============================
> +
> +.. _V4L2_CID_VISCONTI_VIIF_MAIN_SET_RAWPACK_MODE:
> +
> +V4L2_CID_VISCONTI_VIIF_MAIN_SET_RAWPACK_MODE
> +--------------------------------------------
> +
> +This control sets the format to pack multiple RAW pixel values into a word.
> +
> +This control accepts a __u32 value defined as `enum viif_rawpack_mode`.
> +
> +This control should be set before ioctl(S_FMT) and should not be changed after that.

Why not? What happens if I do?

Typically you should be able to make changes to the configuration until the
moment you allocate buffers (VIDIOC_REQBUFS): that locks the configuration into
place and attempts to make changes will return -EBUSY. Until all buffers are
released, then you can make changes again.

> +
> +.. _V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_INPUT_MODE:
> +
> +V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_INPUT_MODE
> +--------------------------------------------
> +
> +This control sets L1ISP preprocessing mode for RAW input images.
> +
> +This control accepts a `struct viif_l1_input_mode_config` instance.
> +
> +This control should be set before ioctl(S_FMT) and should not be changed after that.

Same comment here.

> +
> +.. _V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_RGB_TO_Y_COEF:
> +
> +V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_RGB_TO_Y_COEF
> +-----------------------------------------------
> +
> +This control sets parameters to yield Y value from RGB pixel values.
> +
> +This control accepts a `struct viif_l1_rgb_to_y_coef_config` instance.
> +
> +.. _V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_AG_MODE:
> +
> +V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_AG_MODE
> +-----------------------------------------
> +
> +This control sets rules of generating analog gains for each feature in L1ISP.
> +Related features are:
> +
> +* Optical Black Clamp Correction (OBCC)
> +* Defect Pixel Correction (DPC)
> +* RAW Color Noise Reduction (RCNR)
> +* Lens Shading Correction (LSC)
> +* Color matrix correction (MPRO)
> +* Image quality adjustment (VPRO)
> +
> +The base gain is set with V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_AG control.
> +
> +This control accepts a `struct viif_l1_ag_mode_config` instance.
> +
> +.. _V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_AG:
> +
> +V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_AG
> +------------------------------------
> +
> +This control sets base analog gain commonly used in L1ISP features.
> +Analog gain for each L1ISP feature is generated
> +from the base analog gain and a configuration via V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_AG_MODE control.
> +
> +This control accepts a `struct viif_l1_ag_config` instance.
> +
> +.. _V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_HDRE:
> +
> +V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_HDRE
> +--------------------------------------
> +
> +This controls sets parameters for HDR Expansion feature.
> +
> +This control accepts a `struct viif_l1_hdre_config` instance.
> +
> +.. _V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_IMG_EXTRACTION:
> +
> +V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_IMG_EXTRACTION
> +------------------------------------------------
> +
> +This control sets black level parameters for L1ISP inputs.
> +
> +This control accepts a `struct viif_l1_img_extraction_config` instance.
> +
> +.. _V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_DPC:
> +
> +V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_DPC
> +-------------------------------------
> +
> +This control sets parameters for Defect Pixel Correction.
> +
> +This control accepts a `struct viif_l1_dpc_config` instance.
> +
> +.. _V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_PRESET_WHITE_BALANCE:
> +
> +V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_PRESET_WHITE_BALANCE
> +------------------------------------------------------
> +
> +This control sets parameters for white balance.
> +
> +This control accepts a `struct viif_l1_preset_white_balance_config` instance.
> +
> +.. _V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_RAW_COLOR_NOISE_REDUCTION:
> +
> +V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_RAW_COLOR_NOISE_REDUCTION
> +-----------------------------------------------------------
> +
> +This control sets parameters for RAW color noise reduction (RCNR) feature.
> +
> +This control accepts a `struct viif_l1_raw_color_noise_reduction_config` instance.
> +
> +.. _V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_HDRS:
> +
> +V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_HDRS
> +--------------------------------------
> +
> +This control sets parameters for HDR synthesis.
> +
> +This control accepts a `struct viif_l1_hdrs_config` instance.
> +
> +.. _V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_BLACK_LEVEL_CORRECTION:
> +
> +V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_BLACK_LEVEL_CORRECTION
> +--------------------------------------------------------
> +
> +This control sets parameters for black level correction feature.
> +
> +This control accepts a `struct viif_l1_black_level_correction_config` instance.
> +
> +.. _V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_LSC:
> +
> +V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_LSC
> +-------------------------------------
> +
> +This control sets parameters for Lens Shading Correction feature.
> +L1ISP supports 2 correction methods:
> +
> +* parabola shading
> +* grid shading
> +
> +This control accepts a `struct viif_l1_lsc_config` instance.
> +
> +.. _V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_MAIN_PROCESS:
> +
> +V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_MAIN_PROCESS
> +----------------------------------------------
> +
> +This controls sets parameter for the MAIN PROCESS feature which is composed of:
> +
> +* demosaic
> +* color matrix correction
> +
> +This control accepts a `struct viif_l1_main_process_config` instance.
> +
> +.. _V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_AWB:
> +
> +V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_AWB
> +-------------------------------------
> +
> +This control sets parameter for auto white balance feature.
> +
> +This control accepts a `struct viif_l1_awb_config` instance.
> +
> +.. _V4L2_CID_VISCONTI_VIIF_ISP_L1_LOCK_AWB_GAIN:
> +
> +V4L2_CID_VISCONTI_VIIF_ISP_L1_LOCK_AWB_GAIN
> +-------------------------------------------
> +
> +This control requests enable/disable of lock for AWB gain.
> +
> +This control accepts a u32 value; 0 for disable lock, 1 for enable lock.
> +
> +.. _V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_HDRC:
> +
> +V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_HDRC
> +--------------------------------------
> +
> +This control sets parameter for HDR Compression feature.
> +
> +This control accepts a `struct viif_l1_hdrc_config` instance.
> +
> +.. _V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_HDRC_LTM:
> +
> +V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_HDRC_LTM
> +------------------------------------------
> +
> +This control sets parameter for HDR Compression Local Tone Mapping feature.
> +
> +This control accepts a `struct viif_l1_hdrc_ltm_config` instance.
> +
> +.. _V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_GAMMA:
> +
> +V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_GAMMA
> +---------------------------------------
> +
> +This control sets parameter for gamma correction at L1ISP.
> +
> +This control accepts a `struct viif_l1_gamma_config` instance.
> +
> +.. _V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_IMG_QUALITY_ADJUSTMENT:
> +
> +V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_IMG_QUALITY_ADJUSTMENT
> +--------------------------------------------------------
> +
> +This control sets parameter for VPRO feature which is composed of:
> +
> +* luminance adjustment:
> +
> + * brightness adjustment
> + * linear contrast adjusment
> + * nonlinear contrast adjustment
> + * luminance noise reduction
> + * edge enhancement
> +
> +* chroma adjustment:
> +
> + * chroma suppression
> + * color level adjustment
> + * chroma noise reduction
> + * coring suppression
> + * edge chroma suppression
> + * color noise reduction
> +
> +This control accepts a `struct viif_l1_img_quality_adjustment_config` instance.
> +
> +.. _V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_AVG_LUM_GENERATION:
> +
> +V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_AVG_LUM_GENERATION
> +----------------------------------------------------
> +
> +This control sets parameter for average luminance statistics feature.
> +
> +This control accepts a `struct viif_l1_avg_lum_generation_config` instance.
> +
> +.. _V4L2_CID_VISCONTI_VIIF_ISP_L2_SET_UNDIST:
> +
> +V4L2_CID_VISCONTI_VIIF_ISP_L2_SET_UNDIST
> +----------------------------------------
> +
> +This control sets parameter for the lens undistortion feature of L2ISP.
> +Lens undistortion parameters are defined as either or combination of polinomial parameter and grid table.
> +
> +This control accepts a `struct viif_l2_undist_config` instance.
> +
> +.. _V4L2_CID_VISCONTI_VIIF_ISP_L2_SET_ROI:
> +
> +V4L2_CID_VISCONTI_VIIF_ISP_L2_SET_ROI
> +-------------------------------------
> +
> +This control sets dimensions of intermediate images and scaling parameter of L2ISP.
> +If you want to crop the output image,
> +you should set crop parameter to the corresponding source pad of the ISP subdevice with media-ctl tool.
> +
> +This control accepts a `struct viif_l2_roi_config` instance.
> +
> +.. _V4L2_CID_VISCONTI_VIIF_ISP_L2_SET_GAMMA:
> +
> +V4L2_CID_VISCONTI_VIIF_ISP_L2_SET_GAMMA
> +---------------------------------------
> +
> +This control sets gamma parameter for L2ISP.
> +
> +This control accepts a `struct viif_l2_gamma_config` instance.
> +
> +.. _V4L2_CID_VISCONTI_VIIF_CSI2RX_GET_CALIBRATION_STATUS:
> +
> +V4L2_CID_VISCONTI_VIIF_CSI2RX_GET_CALIBRATION_STATUS
> +----------------------------------------------------
> +
> +This control provides CSI2 receiver calibration status.
> +
> +This control fills a `struct viif_csi2rx_cal_status` instance with current status.
> +
> +.. _V4L2_CID_VISCONTI_VIIF_CSI2RX_GET_ERR_STATUS:
> +
> +V4L2_CID_VISCONTI_VIIF_CSI2RX_GET_ERR_STATUS
> +--------------------------------------------
> +
> +This control provides CSI2 receiver error description.
> +
> +This control fills a `struct viif_csi2rx_err_status` instance with accumerated error status.
> +Note that internal accumerated status is cleared after reading.
> +
> +.. _V4L2_CID_VISCONTI_VIIF_GET_LAST_CAPTURE_STATUS:
> +
> +V4L2_CID_VISCONTI_VIIF_GET_LAST_CAPTURE_STATUS
> +----------------------------------------------
> +
> +This control provides status information for the last captured frame.
> +
> +This control fills a `struct viif_l1_info` instance with current status.
> +
> +.. _V4L2_CID_VISCONTI_VIIF_GET_REPORTED_ERRORS:
> +
> +V4L2_CID_VISCONTI_VIIF_GET_REPORTED_ERRORS
> +------------------------------------------
> +
> +This control provides error information since the last read of this control.
> +
> +This control fills a `struct viif_reported_errors` instance with accumerated error status.
> +Note that internal accumerated status is cleared after reading.
> +
> +Structures
> +==========
> +
> +.. kernel-doc:: include/uapi/linux/visconti_viif.h
> +
> diff --git a/Documentation/userspace-api/media/v4l/vidioc-g-ext-ctrls.rst b/Documentation/userspace-api/media/v4l/vidioc-g-ext-ctrls.rst
> index f9f73530a6be..2f0e4f955167 100644
> --- a/Documentation/userspace-api/media/v4l/vidioc-g-ext-ctrls.rst
> +++ b/Documentation/userspace-api/media/v4l/vidioc-g-ext-ctrls.rst
> @@ -295,6 +295,10 @@ still cause this situation.
>        - ``p_av1_film_grain``
>        - A pointer to a struct :c:type:`v4l2_ctrl_av1_film_grain`. Valid if this control is
>          of type ``V4L2_CTRL_TYPE_AV1_FILM_GRAIN``.
> +    * - void *
> +      - ``ptr``
> +      - A pointer to Visconti ISP control specific structure. Valid if this control is
> +        of type ``V4L2_CTRL_TYPE_VISCONTI_ISP``
>      * - void *
>        - ``ptr``
>        - A pointer to a compound type which can be an N-dimensional array
> diff --git a/Documentation/userspace-api/media/v4l/vidioc-queryctrl.rst b/Documentation/userspace-api/media/v4l/vidioc-queryctrl.rst
> index 4d38acafe8e1..cd57fac8bbf9 100644
> --- a/Documentation/userspace-api/media/v4l/vidioc-queryctrl.rst
> +++ b/Documentation/userspace-api/media/v4l/vidioc-queryctrl.rst
> @@ -549,6 +549,11 @@ See also the examples in :ref:`control`.
>        - n/a
>        - A struct :c:type:`v4l2_ctrl_av1_film_grain`, containing AV1 Film Grain
>          parameters for stateless video decoders.
> +    * - ``V4L2_CTRL_TYPE_VISCONTI_ISP``
> +      - n/a
> +      - n/a
> +      - n/a
> +      - Structs specific for Visconti ISP configuration controls.
>  
>  .. raw:: latex
>  
> diff --git a/Documentation/userspace-api/media/videodev2.h.rst.exceptions b/Documentation/userspace-api/media/videodev2.h.rst.exceptions
> index 3e58aac4ef0b..dbab7527445e 100644
> --- a/Documentation/userspace-api/media/videodev2.h.rst.exceptions
> +++ b/Documentation/userspace-api/media/videodev2.h.rst.exceptions
> @@ -165,6 +165,7 @@ replace symbol V4L2_CTRL_TYPE_AV1_SEQUENCE :c:type:`v4l2_ctrl_type`
>  replace symbol V4L2_CTRL_TYPE_AV1_TILE_GROUP_ENTRY :c:type:`v4l2_ctrl_type`
>  replace symbol V4L2_CTRL_TYPE_AV1_FRAME :c:type:`v4l2_ctrl_type`
>  replace symbol V4L2_CTRL_TYPE_AV1_FILM_GRAIN :c:type:`v4l2_ctrl_type`
> +replace symbol V4L2_CTRL_TYPE_VISCONTI_ISP :c:type:`v4l2_ctrl_type`
>  
>  # V4L2 capability defines
>  replace define V4L2_CAP_VIDEO_CAPTURE device-capabilities

Regards,

	Hans

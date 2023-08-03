Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E49A76E769
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 13:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235442AbjHCLvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 07:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235228AbjHCLvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 07:51:42 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB20B272A;
        Thu,  3 Aug 2023 04:51:39 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 373BpHAC035045;
        Thu, 3 Aug 2023 06:51:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691063477;
        bh=kJWPWSsm6OEEJstHsHAXemewEpmDAmbGeu8zsPi30rQ=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=K83Cpfz9e4rlWXMQc+B0fQgdF2F9fwtIHMOe1Ga1KAdR5jRSvoXD430+H2md8inmY
         erdyRCBDvIlAKCDZHFKGNc1lT6VYoo2XH5TdNnPUwP97EgXsGJfaVmp+dmZvzmKRZf
         /LpxJ8LGRkk+mZ4hTXRqKBKWXmeWVk6bp3asDpOE=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 373BpHZV001631
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 3 Aug 2023 06:51:17 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 3
 Aug 2023 06:51:17 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 3 Aug 2023 06:51:17 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 373BpGoY060082;
        Thu, 3 Aug 2023 06:51:16 -0500
Date:   Thu, 3 Aug 2023 17:21:21 +0530
From:   Jai Luthra <j-luthra@ti.com>
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
CC:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        <niklas.soderlund+renesas@ragnatech.se>,
        Benoit Parrot <bparrot@ti.com>,
        Vaishnav Achath <vaishnav.a@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>, <nm@ti.com>,
        <devarsht@ti.com>
Subject: Re: [PATCH v8 16/16] media: ti: Add CSI2RX support for J721E
Message-ID: <ujh7eeblwwucut2bte6vvk5rkbodudqe54h7bozmtidf3kodfq@hsba2wi25vsq>
References: <20230731-upstream_csi-v8-0-fb7d3661c2c9@ti.com>
 <20230731-upstream_csi-v8-16-fb7d3661c2c9@ti.com>
 <d5d9f2cb-9879-9f25-9b5c-b3b43d551658@ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bdnrev3t3z4w5lmr"
Content-Disposition: inline
In-Reply-To: <d5d9f2cb-9879-9f25-9b5c-b3b43d551658@ideasonboard.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--bdnrev3t3z4w5lmr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Tomi,

Thanks for the review.

On Aug 02, 2023 at 14:04:57 +0300, Tomi Valkeinen wrote:
> On 31/07/2023 11:29, Jai Luthra wrote:
> > From: Pratyush Yadav <p.yadav@ti.com>
> >=20
> > TI's J721E uses the Cadence CSI2RX and DPHY peripherals to facilitate
> > capture over a CSI-2 bus.
> >=20
> > The Cadence CSI2RX IP acts as a bridge between the TI specific parts and
> > the CSI-2 protocol parts. TI then has a wrapper on top of this bridge
> > called the SHIM layer. It takes in data from stream 0, repacks it, and
> > sends it to memory over PSI-L DMA.
> >=20
> > This driver acts as the "front end" to V4L2 client applications. It
> > implements the required ioctls and buffer operations, passes the
> > necessary calls on to the bridge, programs the SHIM layer, and performs
> > DMA via the dmaengine API to finally return the data to a buffer
> > supplied by the application.
> >=20
> > Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> > Co-authored-by: Vaishnav Achath <vaishnav.a@ti.com>
> > Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
> > Co-authored-by: Jai Luthra <j-luthra@ti.com>
> > Signed-off-by: Jai Luthra <j-luthra@ti.com>
> > ---
> > v7->v8:
> > - Move after dt-bindings to keep the series bisectable
> > - Rename compatible to "ti,j721e-csi2rx-shim" to distinguish from the
> >    SoC-specific CSI2RX bridge compatible
> > - Make myself the Maintainer
> > - Support RAW8 and RAW10 formats, and setting the pixel-unwrap size on
> >    SHIM (RAW10 is stored in 16-bit containers, while RAW8 in 8-bit cont=
ainers)
> > - Fix enum_fmt_vid_cap() to respect CAP_IO_MC and only list pixelformats
> >    matching the mbus formats set on the subdev.
> > - Fix enum_framesizes() to stop enumerating more than a single framesize
> >    (reject non-zero fsize->index)
> > - Simplify notifier bound fucntion to use v4l2_create_fwnode_links_to_p=
ad()
> >    and inline the video_register() method
> > - Add support for draining the DMA with an extra buffer, to get rid of
> >    stale data in the pipeline on stream stop (or when frames start
> >    getting dropped due to load)
> > - Queue all available buffers to DMAEngine in the callback, also use a
> >    separate "submitted" queue to track all buffers submitted to DMA
> > - Use video_device_pipeline_start() instead of media_pipeline_start()
> > - Drop support for VB_READ
> > - Print issues in link validation as DEBUG instead of ERROR
> > - s/async_subdev/async_connection
> >=20
> >   MAINTAINERS                                        |    7 +
> >   drivers/media/platform/ti/Kconfig                  |   12 +
> >   drivers/media/platform/ti/Makefile                 |    1 +
> >   drivers/media/platform/ti/j721e-csi2rx/Makefile    |    2 +
> >   .../media/platform/ti/j721e-csi2rx/j721e-csi2rx.c  | 1127 +++++++++++=
+++++++++
> >   5 files changed, 1149 insertions(+)
> >=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index d7b867c57920..1c2d75c30ce7 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -21445,6 +21445,13 @@ F:	Documentation/devicetree/bindings/media/i2c=
/ti,ds90*
> >   F:	drivers/media/i2c/ds90*
> >   F:	include/media/i2c/ds90*
> > +TI J721E CSI2RX DRIVER
> > +M:	Jai Luthra <j-luthra@ti.com>
> > +L:	linux-media@vger.kernel.org
> > +S:	Maintained
> > +F:	Documentation/devicetree/bindings/media/ti,j721e-csi2rx.yaml
> > +F:	drivers/media/platform/ti/j721e-csi2rx/
> > +
> >   TI KEYSTONE MULTICORE NAVIGATOR DRIVERS
> >   M:	Nishanth Menon <nm@ti.com>
> >   M:	Santosh Shilimkar <ssantosh@kernel.org>
> > diff --git a/drivers/media/platform/ti/Kconfig b/drivers/media/platform=
/ti/Kconfig
> > index e1ab56c3be1f..42c908f6e1ae 100644
> > --- a/drivers/media/platform/ti/Kconfig
> > +++ b/drivers/media/platform/ti/Kconfig
> > @@ -63,6 +63,18 @@ config VIDEO_TI_VPE_DEBUG
> >   	help
> >   	  Enable debug messages on VPE driver.
> > +config VIDEO_TI_J721E_CSI2RX
> > +	tristate "TI J721E CSI2RX wrapper layer driver"
> > +	depends on VIDEO_DEV && VIDEO_V4L2_SUBDEV_API
> > +	depends on MEDIA_SUPPORT && MEDIA_CONTROLLER
> > +	depends on PHY_CADENCE_DPHY_RX && VIDEO_CADENCE_CSI2RX
> > +	depends on ARCH_K3 || COMPILE_TEST
> > +	select VIDEOBUF2_DMA_CONTIG
> > +	select V4L2_FWNODE
> > +	help
> > +	  Support for TI CSI2RX wrapper layer. This just enables the wrapper =
driver.
> > +	  The Cadence CSI2RX bridge driver needs to be enabled separately.
> > +
> >   source "drivers/media/platform/ti/am437x/Kconfig"
> >   source "drivers/media/platform/ti/davinci/Kconfig"
> >   source "drivers/media/platform/ti/omap/Kconfig"
> > diff --git a/drivers/media/platform/ti/Makefile b/drivers/media/platfor=
m/ti/Makefile
> > index 98c5fe5c40d6..8a2f74c9380e 100644
> > --- a/drivers/media/platform/ti/Makefile
> > +++ b/drivers/media/platform/ti/Makefile
> > @@ -3,5 +3,6 @@ obj-y +=3D am437x/
> >   obj-y +=3D cal/
> >   obj-y +=3D vpe/
> >   obj-y +=3D davinci/
> > +obj-y +=3D j721e-csi2rx/
> >   obj-y +=3D omap/
> >   obj-y +=3D omap3isp/
> > diff --git a/drivers/media/platform/ti/j721e-csi2rx/Makefile b/drivers/=
media/platform/ti/j721e-csi2rx/Makefile
> > new file mode 100644
> > index 000000000000..377afc1d6280
> > --- /dev/null
> > +++ b/drivers/media/platform/ti/j721e-csi2rx/Makefile
> > @@ -0,0 +1,2 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +obj-$(CONFIG_VIDEO_TI_J721E_CSI2RX) +=3D j721e-csi2rx.o
> > diff --git a/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c b/dr=
ivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
> > new file mode 100644
> > index 000000000000..29f1879cfc25
> > --- /dev/null
> > +++ b/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
> > @@ -0,0 +1,1127 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * TI CSI2RX Shim Wrapper Driver
> > + *
> > + * Copyright (C) 2021 Texas Instruments Incorporated - https://www.ti.=
com/
>=20
> You can update the year above.
>=20

Will do.

> > + * Author: Pratyush Yadav <p.yadav@ti.com>
> > + */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/dmaengine.h>
> > +#include <linux/module.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/platform_device.h>
> > +
> > +#include <media/mipi-csi2.h>
> > +#include <media/v4l2-device.h>
> > +#include <media/v4l2-ioctl.h>
> > +#include <media/v4l2-mc.h>
> > +#include <media/videobuf2-dma-contig.h>
> > +
> > +#define TI_CSI2RX_MODULE_NAME		"j721e-csi2rx"
> > +
> > +#define SHIM_CNTL			0x10
> > +#define SHIM_CNTL_PIX_RST		BIT(0)
> > +
> > +#define SHIM_DMACNTX			0x20
> > +#define SHIM_DMACNTX_EN			BIT(31)
> > +#define SHIM_DMACNTX_YUV422		GENMASK(27, 26)
> > +#define SHIM_DMACNTX_SIZE		GENMASK(21, 20)
> > +#define SHIM_DMACNTX_FMT		GENMASK(5, 0)
> > +#define SHIM_DMACNTX_UYVY		0
> > +#define SHIM_DMACNTX_VYUY		1
> > +#define SHIM_DMACNTX_YUYV		2
> > +#define SHIM_DMACNTX_YVYU		3
> > +#define SHIM_DMACNTX_SIZE_8		0
> > +#define SHIM_DMACNTX_SIZE_16		1
> > +#define SHIM_DMACNTX_SIZE_32		2
> > +
> > +#define SHIM_PSI_CFG0			0x24
> > +#define SHIM_PSI_CFG0_SRC_TAG		GENMASK(15, 0)
> > +#define SHIM_PSI_CFG0_DST_TAG		GENMASK(31, 16)
> > +
> > +#define PSIL_WORD_SIZE_BYTES		16
> > +/*
> > + * There are no hard limits on the width or height. The DMA engine can=
 handle
> > + * all sizes. The max width and height are arbitrary numbers for this =
driver.
> > + * Use 16K * 16K as the arbitrary limit. It is large enough that it is=
 unlikely
> > + * the limit will be hit in practice.
> > + */
> > +#define MAX_WIDTH_BYTES			SZ_16K
> > +#define MAX_HEIGHT_LINES		SZ_16K
> > +
> > +#define DRAIN_TIMEOUT_MS		50
> > +
> > +struct ti_csi2rx_fmt {
> > +	u32				fourcc;	/* Four character code. */
> > +	u32				code;	/* Mbus code. */
> > +	u32				csi_dt;	/* CSI Data type. */
> > +	u8				bpp;	/* Bits per pixel. */
> > +	u8				size;	/* Data size shift when unpacking. */
> > +};
> > +
> > +struct ti_csi2rx_buffer {
> > +	/* Common v4l2 buffer. Must be first. */
> > +	struct vb2_v4l2_buffer		vb;
> > +	struct list_head		list;
> > +	struct ti_csi2rx_dev		*csi;
> > +};
> > +
> > +enum ti_csi2rx_dma_state {
> > +	TI_CSI2RX_DMA_STOPPED,	/* Streaming not started yet. */
> > +	TI_CSI2RX_DMA_IDLE,	/* Streaming but no pending DMA operation. */
> > +	TI_CSI2RX_DMA_ACTIVE,	/* Streaming and pending DMA operation. */
> > +};
> > +
> > +struct ti_csi2rx_dma {
> > +	/* Protects all fields in this struct. */
> > +	spinlock_t			lock;
> > +	struct dma_chan			*chan;
> > +	/* Buffers queued to the driver, waiting to be processed by DMA. */
> > +	struct list_head		queue;
> > +	enum ti_csi2rx_dma_state	state;
> > +	/*
> > +	 * Queue of buffers submitted to DMA engine.
> > +	 */
> > +	struct list_head		submitted;
> > +};
> > +
> > +struct ti_csi2rx_dev {
> > +	struct device			*dev;
> > +	void __iomem			*shim;
> > +	struct v4l2_device		v4l2_dev;
> > +	struct video_device		vdev;
> > +	struct media_device		mdev;
> > +	struct media_pipeline		pipe;
> > +	struct media_pad		pad;
> > +	struct v4l2_async_notifier	notifier;
> > +	struct v4l2_subdev		*subdev;
>=20
> I think "source_subdev" is a better name, to make it clear it's not
> referring to a subdev owned by this driver.
>=20

Good catch, for multi-stream support we did end up renaming this to=20
"source" as this driver gets a subdev of its own. Will update the name=20
here itself in next revision.

> > +	struct vb2_queue		vidq;
> > +	struct mutex			mutex; /* To serialize ioctls. */
> > +	struct v4l2_format		v_fmt;
> > +	struct ti_csi2rx_dma		dma;
> > +	u32				sequence;
> > +};
> > +
> > +static const struct ti_csi2rx_fmt formats[] =3D {
> > +	{
> > +		.fourcc			=3D V4L2_PIX_FMT_YUYV,
> > +		.code			=3D MEDIA_BUS_FMT_YUYV8_1X16,
> > +		.csi_dt			=3D MIPI_CSI2_DT_YUV422_8B,
> > +		.bpp			=3D 16,
> > +		.size			=3D SHIM_DMACNTX_SIZE_8,
> > +	}, {
> > +		.fourcc			=3D V4L2_PIX_FMT_UYVY,
> > +		.code			=3D MEDIA_BUS_FMT_UYVY8_1X16,
> > +		.csi_dt			=3D MIPI_CSI2_DT_YUV422_8B,
> > +		.bpp			=3D 16,
> > +		.size			=3D SHIM_DMACNTX_SIZE_8,
> > +	}, {
> > +		.fourcc			=3D V4L2_PIX_FMT_YVYU,
> > +		.code			=3D MEDIA_BUS_FMT_YVYU8_1X16,
> > +		.csi_dt			=3D MIPI_CSI2_DT_YUV422_8B,
> > +		.bpp			=3D 16,
> > +		.size			=3D SHIM_DMACNTX_SIZE_8,
> > +	}, {
> > +		.fourcc			=3D V4L2_PIX_FMT_VYUY,
> > +		.code			=3D MEDIA_BUS_FMT_VYUY8_1X16,
> > +		.csi_dt			=3D MIPI_CSI2_DT_YUV422_8B,
> > +		.bpp			=3D 16,
> > +		.size			=3D SHIM_DMACNTX_SIZE_8,
> > +	}, {
> > +		.fourcc			=3D V4L2_PIX_FMT_SBGGR8,
> > +		.code			=3D MEDIA_BUS_FMT_SBGGR8_1X8,
> > +		.csi_dt			=3D MIPI_CSI2_DT_RAW8,
> > +		.bpp			=3D 8,
> > +		.size			=3D SHIM_DMACNTX_SIZE_8,
> > +	}, {
> > +		.fourcc			=3D V4L2_PIX_FMT_SGBRG8,
> > +		.code			=3D MEDIA_BUS_FMT_SGBRG8_1X8,
> > +		.csi_dt			=3D MIPI_CSI2_DT_RAW8,
> > +		.bpp			=3D 8,
> > +		.size			=3D SHIM_DMACNTX_SIZE_8,
> > +	}, {
> > +		.fourcc			=3D V4L2_PIX_FMT_SGRBG8,
> > +		.code			=3D MEDIA_BUS_FMT_SGRBG8_1X8,
> > +		.csi_dt			=3D MIPI_CSI2_DT_RAW8,
> > +		.bpp			=3D 8,
> > +		.size			=3D SHIM_DMACNTX_SIZE_8,
> > +	}, {
> > +		.fourcc			=3D V4L2_PIX_FMT_SRGGB8,
> > +		.code			=3D MEDIA_BUS_FMT_SRGGB8_1X8,
> > +		.csi_dt			=3D MIPI_CSI2_DT_RAW8,
> > +		.bpp			=3D 8,
> > +		.size			=3D SHIM_DMACNTX_SIZE_8,
> > +	}, {
> > +		.fourcc			=3D V4L2_PIX_FMT_SBGGR10,
> > +		.code			=3D MEDIA_BUS_FMT_SBGGR10_1X10,
> > +		.csi_dt			=3D MIPI_CSI2_DT_RAW10,
> > +		.bpp			=3D 16,
> > +		.size			=3D SHIM_DMACNTX_SIZE_16,
> > +	}, {
> > +		.fourcc			=3D V4L2_PIX_FMT_SGBRG10,
> > +		.code			=3D MEDIA_BUS_FMT_SGBRG10_1X10,
> > +		.csi_dt			=3D MIPI_CSI2_DT_RAW10,
> > +		.bpp			=3D 16,
> > +		.size			=3D SHIM_DMACNTX_SIZE_16,
> > +	}, {
> > +		.fourcc			=3D V4L2_PIX_FMT_SGRBG10,
> > +		.code			=3D MEDIA_BUS_FMT_SGRBG10_1X10,
> > +		.csi_dt			=3D MIPI_CSI2_DT_RAW10,
> > +		.bpp			=3D 16,
> > +		.size			=3D SHIM_DMACNTX_SIZE_16,
> > +	}, {
> > +		.fourcc			=3D V4L2_PIX_FMT_SRGGB10,
> > +		.code			=3D MEDIA_BUS_FMT_SRGGB10_1X10,
> > +		.csi_dt			=3D MIPI_CSI2_DT_RAW10,
> > +		.bpp			=3D 16,
> > +		.size			=3D SHIM_DMACNTX_SIZE_16,
> > +	},
> > +
> > +	/* More formats can be supported but they are not listed for now. */
> > +};
> > +
> > +static const unsigned int num_formats =3D ARRAY_SIZE(formats);
> > +
> > +/* Forward declaration needed by ti_csi2rx_dma_callback. */
> > +static int ti_csi2rx_start_dma(struct ti_csi2rx_dev *csi,
> > +			       struct ti_csi2rx_buffer *buf);
> > +
> > +static const struct ti_csi2rx_fmt *find_format_by_pix(u32 pixelformat)
> > +{
> > +	unsigned int i;
> > +
> > +	for (i =3D 0; i < num_formats; i++) {
> > +		if (formats[i].fourcc =3D=3D pixelformat)
> > +			return &formats[i];
> > +	}
> > +
> > +	return NULL;
> > +}
> > +
> > +static const struct ti_csi2rx_fmt *find_format_by_code(u32 code)
> > +{
> > +	unsigned int i;
> > +
> > +	for (i =3D 0; i < num_formats; i++) {
> > +		if (formats[i].code =3D=3D code)
> > +			return &formats[i];
> > +	}
> > +
> > +	return NULL;
> > +}
> > +
> > +static void ti_csi2rx_fill_fmt(const struct ti_csi2rx_fmt *csi_fmt,
> > +			       struct v4l2_format *v4l2_fmt)
> > +{
> > +	struct v4l2_pix_format *pix =3D &v4l2_fmt->fmt.pix;
> > +	unsigned int pixels_in_word;
> > +	u8 bpp =3D csi_fmt->bpp;
> > +	u32 bpl;
> > +
> > +	pixels_in_word =3D PSIL_WORD_SIZE_BYTES * 8 / bpp;
> > +
> > +	pix->width =3D clamp_t(unsigned int, pix->width,
> > +			     pixels_in_word,
> > +			     MAX_WIDTH_BYTES * 8 / bpp);
> > +	pix->width =3D rounddown(pix->width, pixels_in_word);
> > +
> > +	pix->height =3D clamp_t(unsigned int, pix->height, 1, MAX_HEIGHT_LINE=
S);
> > +
> > +	v4l2_fmt->type =3D V4L2_BUF_TYPE_VIDEO_CAPTURE;
> > +	pix->pixelformat =3D csi_fmt->fourcc;
> > +	pix->colorspace =3D V4L2_COLORSPACE_SRGB;
> > +	pix->sizeimage =3D pix->height * pix->width * (bpp / 8);
> > +
> > +	bpl =3D (pix->width * ALIGN(bpp, 8)) >> 3;
>=20
> You do "/ 8" and "* 8" elsewhere in the function, so I think it makes sen=
se
> to "/ 8" here too, instead of ">> 3".

Will fix.

>=20
> Is this correct? Why is aligned bpp used here, but when calculating
> sizeimage, bpp is not aligned?

Hmm I agree this whole function is quite confusing, It should either be=20
ALIGN(bpp, 8) everywhere or we can just remove that given the hardware=20
is unwrapping currently supported formats to multiples of 8 bits (even=20
RAW10/RAW12) and the bpp in the table above matches that.

>=20
> > +	pix->bytesperline =3D ALIGN(bpl, 16);
>=20
> Why align to 16?

This might be redundant given we are rounding down the width to make=20
sure it's a multiple of PSIL_WORD_SIZE_BYTES.

>=20
> Shouldn't sizeimage usually be bytesperline * height?
>=20
> You could add a few comments here to clarify all the aligns, roundings and
> clampings.

Will do.

>=20
> > +}
> > +
> > +static int ti_csi2rx_querycap(struct file *file, void *priv,
> > +			      struct v4l2_capability *cap)
> > +{
> > +	strscpy(cap->driver, TI_CSI2RX_MODULE_NAME, sizeof(cap->driver));
> > +	strscpy(cap->card, TI_CSI2RX_MODULE_NAME, sizeof(cap->card));
> > +
> > +	return 0;
> > +}
> > +
> > +static int ti_csi2rx_enum_fmt_vid_cap(struct file *file, void *priv,
> > +				      struct v4l2_fmtdesc *f)
> > +{
> > +	const struct ti_csi2rx_fmt *fmt =3D NULL;
> > +
> > +	if (f->mbus_code) {
> > +		if (f->index > 0)
> > +			return -EINVAL;
>=20
> This fails to enumerate the formats if mbus_code is set, doesn't it?
>=20

Sakari is correct, this is required according to the spec for devices=20
that set the V4L2_CAP_IO_MC capability. Caught this while enabling=20
libcamera simple pipeline:)

> > +
> > +		fmt =3D find_format_by_code(f->mbus_code);
> > +	} else {
> > +		if (f->index >=3D num_formats)
> > +			return -EINVAL;
> > +
> > +		fmt =3D &formats[f->index];
> > +	}
> > +
> > +	if (!fmt)
> > +		return -EINVAL;
> > +
> > +	f->pixelformat =3D fmt->fourcc;
> > +	memset(f->reserved, 0, sizeof(f->reserved));
> > +	f->type =3D V4L2_BUF_TYPE_VIDEO_CAPTURE;
> > +
> > +	return 0;
> > +}
> > +
> > +static int ti_csi2rx_g_fmt_vid_cap(struct file *file, void *prov,
> > +				   struct v4l2_format *f)
> > +{
> > +	struct ti_csi2rx_dev *csi =3D video_drvdata(file);
> > +
> > +	*f =3D csi->v_fmt;
> > +
> > +	return 0;
> > +}
> > +
> > +static int ti_csi2rx_try_fmt_vid_cap(struct file *file, void *priv,
> > +				     struct v4l2_format *f)
> > +{
> > +	const struct ti_csi2rx_fmt *fmt;
> > +
> > +	/*
> > +	 * Default to the first format if the requested pixel format code isn=
't
> > +	 * supported.
> > +	 */
> > +	fmt =3D find_format_by_pix(f->fmt.pix.pixelformat);
> > +	if (!fmt)
> > +		fmt =3D &formats[0];
> > +
> > +	if (f->fmt.pix.field =3D=3D V4L2_FIELD_ANY)
> > +		f->fmt.pix.field =3D V4L2_FIELD_NONE;
> > +
> > +	if (f->fmt.pix.field !=3D V4L2_FIELD_NONE)
> > +		/* Interlaced formats are not supported. */
> > +		f->fmt.pix.field =3D V4L2_FIELD_NONE;
>=20
> Can't you just always set the field to V4L2_FIELD_NONE?
>=20

Will fix.

> > +	ti_csi2rx_fill_fmt(fmt, f);
> > +
> > +	return 0;
> > +}
> > +
> > +static int ti_csi2rx_s_fmt_vid_cap(struct file *file, void *priv,
> > +				   struct v4l2_format *f)
> > +{
> > +	struct ti_csi2rx_dev *csi =3D video_drvdata(file);
> > +	struct vb2_queue *q =3D &csi->vidq;
> > +	int ret;
> > +
> > +	if (vb2_is_busy(q))
> > +		return -EBUSY;
> > +
> > +	ret =3D ti_csi2rx_try_fmt_vid_cap(file, priv, f);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	csi->v_fmt =3D *f;
> > +
> > +	return 0;
> > +}
> > +
> > +static int ti_csi2rx_enum_framesizes(struct file *file, void *fh,
> > +				     struct v4l2_frmsizeenum *fsize)
> > +{
> > +	const struct ti_csi2rx_fmt *fmt;
> > +	unsigned int pixels_in_word;
> > +	u8 bpp;
> > +
> > +	fmt =3D find_format_by_pix(fsize->pixel_format);
> > +	if (!fmt || fsize->index !=3D 0)
> > +		return -EINVAL;
> > +
> > +	bpp =3D ALIGN(fmt->bpp, 8);
> > +
> > +	/*
> > +	 * Number of pixels in one PSI-L word. The transfer happens in multip=
les
> > +	 * of PSI-L word sizes.
> > +	 */
> > +	pixels_in_word =3D PSIL_WORD_SIZE_BYTES * 8 / bpp;
> > +
> > +	fsize->type =3D V4L2_FRMSIZE_TYPE_STEPWISE;
> > +	fsize->stepwise.min_width =3D pixels_in_word;
> > +	fsize->stepwise.max_width =3D rounddown(MAX_WIDTH_BYTES * 8 / bpp,
> > +					      pixels_in_word);
> > +	fsize->stepwise.step_width =3D pixels_in_word;
> > +	fsize->stepwise.min_height =3D 1;
> > +	fsize->stepwise.max_height =3D MAX_HEIGHT_LINES;
> > +	fsize->stepwise.step_height =3D 1;
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct v4l2_ioctl_ops csi_ioctl_ops =3D {
> > +	.vidioc_querycap      =3D ti_csi2rx_querycap,
> > +	.vidioc_enum_fmt_vid_cap =3D ti_csi2rx_enum_fmt_vid_cap,
> > +	.vidioc_try_fmt_vid_cap =3D ti_csi2rx_try_fmt_vid_cap,
> > +	.vidioc_g_fmt_vid_cap =3D ti_csi2rx_g_fmt_vid_cap,
> > +	.vidioc_s_fmt_vid_cap =3D ti_csi2rx_s_fmt_vid_cap,
> > +	.vidioc_enum_framesizes =3D ti_csi2rx_enum_framesizes,
> > +	.vidioc_reqbufs       =3D vb2_ioctl_reqbufs,
> > +	.vidioc_create_bufs   =3D vb2_ioctl_create_bufs,
> > +	.vidioc_prepare_buf   =3D vb2_ioctl_prepare_buf,
> > +	.vidioc_querybuf      =3D vb2_ioctl_querybuf,
> > +	.vidioc_qbuf          =3D vb2_ioctl_qbuf,
> > +	.vidioc_dqbuf         =3D vb2_ioctl_dqbuf,
> > +	.vidioc_expbuf        =3D vb2_ioctl_expbuf,
> > +	.vidioc_streamon      =3D vb2_ioctl_streamon,
> > +	.vidioc_streamoff     =3D vb2_ioctl_streamoff,
> > +};
> > +
> > +static const struct v4l2_file_operations csi_fops =3D {
> > +	.owner =3D THIS_MODULE,
> > +	.open =3D v4l2_fh_open,
> > +	.release =3D vb2_fop_release,
> > +	.read =3D vb2_fop_read,
> > +	.poll =3D vb2_fop_poll,
> > +	.unlocked_ioctl =3D video_ioctl2,
> > +	.mmap =3D vb2_fop_mmap,
> > +};
> > +
> > +static int csi_async_notifier_bound(struct v4l2_async_notifier *notifi=
er,
> > +				    struct v4l2_subdev *subdev,
> > +				    struct v4l2_async_connection *asc)
> > +{
> > +	struct ti_csi2rx_dev *csi =3D dev_get_drvdata(notifier->v4l2_dev->dev=
);
> > +
> > +	csi->subdev =3D subdev;
> > +
> > +	return 0;
> > +}
> > +
> > +static int csi_async_notifier_complete(struct v4l2_async_notifier *not=
ifier)
> > +{
> > +	struct ti_csi2rx_dev *csi =3D dev_get_drvdata(notifier->v4l2_dev->dev=
);
> > +	struct video_device *vdev =3D &csi->vdev;
> > +	int ret;
> > +
> > +	ret =3D video_register_device(vdev, VFL_TYPE_VIDEO, -1);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D v4l2_create_fwnode_links_to_pad(csi->subdev, &csi->pad,
> > +					      MEDIA_LNK_FL_IMMUTABLE | MEDIA_LNK_FL_ENABLED);
> > +
> > +	if (ret) {
> > +		video_unregister_device(vdev);
> > +		return ret;
> > +	}
> > +
> > +	return v4l2_device_register_subdev_nodes(&csi->v4l2_dev);
> > +}
> > +
> > +static const struct v4l2_async_notifier_operations csi_async_notifier_=
ops =3D {
> > +	.bound =3D csi_async_notifier_bound,
> > +	.complete =3D csi_async_notifier_complete,
> > +};
> > +
> > +static int ti_csi2rx_init_subdev(struct ti_csi2rx_dev *csi)
>=20
> This is misnamed. ti_csi2rx_async_notifier_register()?
>=20

Will fix.

> > +{
> > +	struct fwnode_handle *fwnode;
> > +	struct v4l2_async_connection *asc;
> > +	struct device_node *node;
> > +	int ret;
> > +
> > +	node =3D of_get_child_by_name(csi->dev->of_node, "csi-bridge");
> > +	if (!node)
> > +		return -EINVAL;
> > +
> > +	fwnode =3D of_fwnode_handle(node);
> > +	if (!fwnode) {
> > +		of_node_put(node);
> > +		return -EINVAL;
> > +	}
> > +
> > +	v4l2_async_nf_init(&csi->notifier, &csi->v4l2_dev);
> > +	csi->notifier.ops =3D &csi_async_notifier_ops;
> > +
> > +	asc =3D v4l2_async_nf_add_fwnode(&csi->notifier, fwnode,
> > +				       struct v4l2_async_connection);
> > +	of_node_put(node);
> > +	if (IS_ERR(asc)) {
> > +		v4l2_async_nf_cleanup(&csi->notifier);
> > +		return PTR_ERR(asc);
> > +	}
> > +
> > +	ret =3D v4l2_async_nf_register(&csi->notifier);
> > +	if (ret) {
> > +		v4l2_async_nf_cleanup(&csi->notifier);
> > +		return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static void ti_csi2rx_setup_shim(struct ti_csi2rx_dev *csi)
> > +{
> > +	const struct ti_csi2rx_fmt *fmt;
> > +	unsigned int reg;
> > +
> > +	fmt =3D find_format_by_pix(csi->v_fmt.fmt.pix.pixelformat);
> > +	if (!fmt) {
> > +		dev_err(csi->dev, "Unknown format\n");
> > +		return;
> > +	}
>=20
> The error print here is rather vague, and as there's no error code return=
ed,
> the caller doesn't handle the error.
>=20

Will fix.

> > +
> > +	/* De-assert the pixel interface reset. */
> > +	reg =3D SHIM_CNTL_PIX_RST;
> > +	writel(reg, csi->shim + SHIM_CNTL);
> > +
> > +	reg =3D SHIM_DMACNTX_EN;
> > +	reg |=3D FIELD_PREP(SHIM_DMACNTX_FMT, fmt->csi_dt);
> > +
> > +	/*
> > +	 * Using the values from the documentation gives incorrect ordering f=
or
> > +	 * the luma and chroma components. In practice, the "reverse" format
> > +	 * gives the correct image. So for example, if the image is in UYVY, =
the
> > +	 * reverse would be YVYU.
> > +	 */
> > +	switch (fmt->fourcc) {
> > +	case V4L2_PIX_FMT_UYVY:
> > +		reg |=3D FIELD_PREP(SHIM_DMACNTX_YUV422,
> > +					SHIM_DMACNTX_YVYU);
> > +		break;
> > +	case V4L2_PIX_FMT_VYUY:
> > +		reg |=3D FIELD_PREP(SHIM_DMACNTX_YUV422,
> > +					SHIM_DMACNTX_YUYV);
> > +		break;
> > +	case V4L2_PIX_FMT_YUYV:
> > +		reg |=3D FIELD_PREP(SHIM_DMACNTX_YUV422,
> > +					SHIM_DMACNTX_VYUY);
> > +		break;
> > +	case V4L2_PIX_FMT_YVYU:
> > +		reg |=3D FIELD_PREP(SHIM_DMACNTX_YUV422,
> > +					SHIM_DMACNTX_UYVY);
> > +		break;
> > +	default:
> > +		/* Ignore if not YUV 4:2:2 */
> > +		break;
> > +	}
> > +
> > +	reg |=3D FIELD_PREP(SHIM_DMACNTX_SIZE, fmt->size);
> > +
> > +	writel(reg, csi->shim + SHIM_DMACNTX);
> > +
> > +	reg =3D FIELD_PREP(SHIM_PSI_CFG0_SRC_TAG, 0) |
> > +	      FIELD_PREP(SHIM_PSI_CFG0_DST_TAG, 0);
> > +	writel(reg, csi->shim + SHIM_PSI_CFG0);
> > +}
> > +
> > +static void ti_csi2rx_drain_callback(void *param)
> > +{
> > +	struct completion *drain_complete =3D param;
> > +
> > +	complete(drain_complete);
> > +}
> > +
> > +static int ti_csi2rx_drain_dma(struct ti_csi2rx_dev *csi)
> > +{
>=20
> I think it would be good to explain in a comment somewhere what why this =
dma
> draining is needed and how it works.
>=20

Makes sense, will do.

> > +	struct dma_async_tx_descriptor *desc;
> > +	struct device *dev =3D csi->dma.chan->device->dev;
> > +	struct completion drain_complete;
> > +	void *buf;
> > +	size_t len =3D csi->v_fmt.fmt.pix.sizeimage;
> > +	dma_addr_t addr;
> > +	dma_cookie_t cookie;
> > +	int ret;
> > +
> > +	init_completion(&drain_complete);
> > +
> > +	buf =3D dma_alloc_coherent(dev, len, &addr, GFP_KERNEL | GFP_ATOMIC);
> > +	if (!buf)
> > +		return -ENOMEM;
>=20
> If I understand right, this is called when the streaming is stopped, but
> could also be called on frame drops? You're allocating a DMA buffer for a
> full frame. Large runtime DMA buffer allocations are a bit scary. What
> happens if it fails?
>=20
> Is it possible to preallocate, or use smaller buffers (perhaps with multi=
ple
> dma operations) to do the flush?
>=20
> The dma doesn't support writing to a constant address, does it (in which
> case a very small buffer would suffice)?

Hmm you're absolutely right. Will have to experiment if doing multiple=20
dma ops on a small buffer would be feasible for multi-camera/stream=20
scenarios. But at the minimum will switch to allocating the drain buffer=20
only one time in the next revision.

>=20
>  Tomi
>=20

--=20
Thanks,
Jai

GPG Fingerprint: 4DE0 D818 E5D5 75E8 D45A AFC5 43DE 91F9 249A 7145

--bdnrev3t3z4w5lmr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEETeDYGOXVdejUWq/FQ96R+SSacUUFAmTLlLgACgkQQ96R+SSa
cUUVgxAAzUz2DYah5iEJik57HQ9XDFolOHPWKmOv1dTUbkz8LbSiQH7uwjyVcZOl
rpLij5wiV7F3ciCEJ2eGoZJ+L9efYJbtRGdmclR0V5aru9YltxJGdtAAH+x9uiC0
48SsxRjY3rOhCfeg/OEqg7iAl1kINzl04EBUgIhffvx6fbSsr+wugBOQK73DekJt
qH3Dqp5RJPPVLvl9vWj8T+pObCVOhh1EfbqPjkJhZUt0y7FTOOMFUMiEuB1cxThA
4r0Bue63v4VcGsViqn2XNNcWF1sVO5XikE31o3uMsstS307DIvcv/2uWYiYK8QT/
KVLQRd8krKR5hQzk1ERp4ftQrZoXW7ZVgQYN5HbD47c4P6BqAC0jJ29nAAfNhsvT
mgM2knfzYkvDYlNstGtQEv3DZzqNZuntjVlpPqkzSwyHh5wvJw+1L1vcvw0ODuOG
OYzzsCTteZwIHavKhl2hRjsYKGa8I1Yhw9C1/LrZ/+gTV43u0b6NJD9BE204UHB5
anSkD64tfase5Pcl5LhRvA5ACkySkpMnhC8oG2AwwCVfMp+wYoBTQw4yeDB0hstL
F5KT+WZpMlnZP+i6SWsyYIayvhU/5sv5mhSem5ZlG6gN7eh138LeDHXxTbofGzUd
6sLygLoP+ZvGM3aEHn1OQ7FQGqSeTVv5F6cpoO0puHvrriPS9jU=
=j4Zy
-----END PGP SIGNATURE-----

--bdnrev3t3z4w5lmr--

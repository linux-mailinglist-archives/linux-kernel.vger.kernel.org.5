Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5C4076E69F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 13:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234472AbjHCLSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 07:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjHCLS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 07:18:28 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E41EA;
        Thu,  3 Aug 2023 04:18:26 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 373BI88o019535;
        Thu, 3 Aug 2023 06:18:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691061488;
        bh=ni6PL/3dudKc2Fc/J5A9DtRCFsxDE14yZ1kucU8DiWo=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=ex5cTxxvHmFmMm1AcJxM5WmHyX/wE3hXfjbtw/5W1xCtoUhdtR7BJAdCNq7d5IcSA
         qf3tDKTVYhKKNmzPdaUluF3GQv+Ftt/AUOHqNYCwmFnf5UBEGNEG2gYXkNvHB539Td
         C//mALYZhNtT+NdTpWL5udHQexUpJsi0NS4EKXCs=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 373BI8En016292
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 3 Aug 2023 06:18:08 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 3
 Aug 2023 06:18:08 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 3 Aug 2023 06:18:08 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 373BI6Qc038904;
        Thu, 3 Aug 2023 06:18:07 -0500
Date:   Thu, 3 Aug 2023 16:48:11 +0530
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
Subject: Re: [PATCH v8 07/16] media: cadence: csi2rx: Add get_fmt and set_fmt
 pad ops
Message-ID: <rgeb7h25fdykv2jz5xbcd6u4kfuanbmbbx763oifba6bye7zft@nbqxarwe6z2a>
References: <20230731-upstream_csi-v8-0-fb7d3661c2c9@ti.com>
 <20230731-upstream_csi-v8-7-fb7d3661c2c9@ti.com>
 <bf914485-09af-4f32-0636-d1a7232216d0@ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gssmw375yvf33hoq"
Content-Disposition: inline
In-Reply-To: <bf914485-09af-4f32-0636-d1a7232216d0@ideasonboard.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--gssmw375yvf33hoq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Tomi,

Thanks for the review.

On Aug 02, 2023 at 11:48:52 +0300, Tomi Valkeinen wrote:
> On 31/07/2023 11:29, Jai Luthra wrote:
> > From: Pratyush Yadav <p.yadav@ti.com>
> >=20
> > The format is needed to calculate the link speed for the external DPHY
> > configuration. It is not right to query the format from the source
> > subdev. Add get_fmt and set_fmt pad operations so that the format can be
> > configured and correct bpp be selected.
> >=20
> > Initialize and use the v4l2 subdev active state to keep track of the
> > active formats. Also propagate the new format from the sink pad to all
> > the source pads.
> >=20
> > Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> > Co-authored-by: Jai Luthra <j-luthra@ti.com>
> > Signed-off-by: Jai Luthra <j-luthra@ti.com>
> > ---
> > v7->v8:
> > - Use active subdev state to use v4l2_subdev_get_fmt
> > - Propagate formats from sink to source pads
> > - Drop Laurent's R-by because of the above changes
> >=20
> >   drivers/media/platform/cadence/cdns-csi2rx.c | 107 ++++++++++++++++++=
++++++++-
> >   1 file changed, 106 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/med=
ia/platform/cadence/cdns-csi2rx.c
> > index 83d1fadd592b..4f9654366485 100644
> > --- a/drivers/media/platform/cadence/cdns-csi2rx.c
> > +++ b/drivers/media/platform/cadence/cdns-csi2rx.c
> > @@ -61,6 +61,11 @@ enum csi2rx_pads {
> >   	CSI2RX_PAD_MAX,
> >   };
> > +struct csi2rx_fmt {
> > +	u32				code;
> > +	u8				bpp;
> > +};
> > +
> >   struct csi2rx_priv {
> >   	struct device			*dev;
> >   	unsigned int			count;
> > @@ -95,6 +100,36 @@ struct csi2rx_priv {
> >   	int				source_pad;
> >   };
> > +static const struct csi2rx_fmt formats[] =3D {
> > +	{
> > +		.code	=3D MEDIA_BUS_FMT_YUYV8_1X16,
> > +		.bpp	=3D 16,
> > +	},
> > +	{
> > +		.code	=3D MEDIA_BUS_FMT_UYVY8_1X16,
> > +		.bpp	=3D 16,
> > +	},
> > +	{
> > +		.code	=3D MEDIA_BUS_FMT_YVYU8_1X16,
> > +		.bpp	=3D 16,
> > +	},
> > +	{
> > +		.code	=3D MEDIA_BUS_FMT_VYUY8_1X16,
> > +		.bpp	=3D 16,
> > +	},
> > +};
>=20
> I think you could just squash the "media: cadence: csi2rx: Support RAW8 a=
nd
> RAW10 formats" into this one. Also, the lines could well be one-liners:
>=20
> 	{ .code	=3D MEDIA_BUS_FMT_YUYV8_1X16, .bpp =3D 16, },
>=20

Will fix.

>=20
> > +static const struct csi2rx_fmt *csi2rx_get_fmt_by_code(u32 code)
> > +{
> > +	unsigned int i;
> > +
> > +	for (i =3D 0; i < ARRAY_SIZE(formats); i++)
> > +		if (formats[i].code =3D=3D code)
> > +			return &formats[i];
> > +
> > +	return NULL;
> > +}
> > +
> >   static inline
> >   struct csi2rx_priv *v4l2_subdev_to_csi2rx(struct v4l2_subdev *subdev)
> >   {
> > @@ -303,12 +338,75 @@ static int csi2rx_s_stream(struct v4l2_subdev *su=
bdev, int enable)
> >   	return ret;
> >   }
> > +static int csi2rx_set_fmt(struct v4l2_subdev *subdev,
> > +			  struct v4l2_subdev_state *state,
> > +			  struct v4l2_subdev_format *format)
> > +{
> > +	struct v4l2_mbus_framefmt *fmt;
> > +	unsigned int i;
> > +
> > +	/* No transcoding, source and sink formats must match. */
> > +	if (format->pad !=3D CSI2RX_PAD_SINK)
> > +		return v4l2_subdev_get_fmt(subdev, state, format);
> > +
> > +	if (!csi2rx_get_fmt_by_code(format->format.code))
> > +		format->format.code =3D formats[0].code;
> > +
> > +	format->format.field =3D V4L2_FIELD_NONE;
> > +
> > +	/* Set sink format */
> > +	fmt =3D v4l2_subdev_get_pad_format(subdev, state, format->pad);
> > +	if (!fmt)
> > +		return -EINVAL;
> > +
> > +	*fmt =3D format->format;
> > +
> > +	/* Propagate to source formats */
> > +	for (i =3D CSI2RX_PAD_SOURCE_STREAM0; i < CSI2RX_PAD_MAX; i++) {
> > +		fmt =3D v4l2_subdev_get_pad_format(subdev, state, i);
> > +		if (!fmt)
> > +			return -EINVAL;
> > +		*fmt =3D format->format;
> > +	}
>=20
> Not really part of this patch, but why does csi2rx create more than one
> source pad? It doesn't support streams, so how are those pads used?
>=20

These pads correspond to the 4 output pixel data "streams" the Cadence=20
IP provides. We can route the incoming pixel data over MIPI CSI to=20
different peripherals in the SoC, while doing some optional filtering on=20
VC and DT using the STREAM_DATA_CFG register.

Different vendors may integrate these streams in their own way. For=20
example on AM62A this is how they are mapped in the hardware [1]:

pad1 -> shim   -> upto 32x dma chans
pad2 ->
pad3 -> vp0    -> ISP
pad4 -> vp1

For shim the idea is to pass-through all VCs and DTs, as shim can filter=20
and send different v4l2-streams to different dma chans.

For the ISP (when supported) we will have to filter for a specific VC or=20
DT here, in case multiple streams are coming over CSI.

[1] TRM, Section 12.6.4 https://www.ti.com/lit/ug/spruj16/spruj16.pdf=20

> > +	return 0;
> > +}
> > +
> > +static int csi2rx_init_cfg(struct v4l2_subdev *subdev,
> > +			   struct v4l2_subdev_state *state)
> > +{
> > +	struct v4l2_subdev_format format =3D {
> > +		.which =3D state ? V4L2_SUBDEV_FORMAT_TRY
> > +			: V4L2_SUBDEV_FORMAT_ACTIVE,
>=20
> I don't think this is correct. If you enable the active state, you'll alw=
ays
> get a state here, and thus this function doesn't really know if it is TRY=
 or
> ACTIVE state (nor should it care).

My bad I forgot to clean this up. Will fix in next revision.

>=20
> > +		.pad =3D CSI2RX_PAD_SINK,
> > +		.format =3D {
> > +			.width =3D 640,
> > +			.height =3D 480,
> > +			.code =3D MEDIA_BUS_FMT_UYVY8_1X16,
> > +			.field =3D V4L2_FIELD_NONE,
> > +			.colorspace =3D V4L2_COLORSPACE_SRGB,
> > +			.ycbcr_enc =3D V4L2_YCBCR_ENC_601,
> > +			.quantization =3D V4L2_QUANTIZATION_LIM_RANGE,
> > +			.xfer_func =3D V4L2_XFER_FUNC_SRGB,
> > +		},
> > +	};
> > +
> > +	return csi2rx_set_fmt(subdev, state, &format);
> > +}
> > +
> > +static const struct v4l2_subdev_pad_ops csi2rx_pad_ops =3D {
> > +	.get_fmt	=3D v4l2_subdev_get_fmt,
> > +	.set_fmt	=3D csi2rx_set_fmt,
> > +	.init_cfg	=3D csi2rx_init_cfg,
> > +};
> > +
> >   static const struct v4l2_subdev_video_ops csi2rx_video_ops =3D {
> >   	.s_stream	=3D csi2rx_s_stream,
> >   };
> >   static const struct v4l2_subdev_ops csi2rx_subdev_ops =3D {
> >   	.video		=3D &csi2rx_video_ops,
> > +	.pad		=3D &csi2rx_pad_ops,
> >   };
> >   static int csi2rx_async_bound(struct v4l2_async_notifier *notifier,
> > @@ -532,9 +630,13 @@ static int csi2rx_probe(struct platform_device *pd=
ev)
> >   	if (ret)
> >   		goto err_cleanup;
> > +	ret =3D v4l2_subdev_init_finalize(&csi2rx->subdev);
> > +	if (ret)
> > +		goto err_cleanup;
> > +
> >   	ret =3D v4l2_async_register_subdev(&csi2rx->subdev);
> >   	if (ret < 0)
> > -		goto err_cleanup;
> > +		goto err_free_state;
> >   	dev_info(&pdev->dev,
> >   		 "Probed CSI2RX with %u/%u lanes, %u streams, %s D-PHY\n",
> > @@ -544,6 +646,8 @@ static int csi2rx_probe(struct platform_device *pde=
v)
> >   	return 0;
> > +err_free_state:
> > +	v4l2_subdev_cleanup(&csi2rx->subdev);
> >   err_cleanup:
> >   	v4l2_async_nf_unregister(&csi2rx->notifier);
> >   	v4l2_async_nf_cleanup(&csi2rx->notifier);
> > @@ -560,6 +664,7 @@ static void csi2rx_remove(struct platform_device *p=
dev)
> >   	v4l2_async_nf_unregister(&csi2rx->notifier);
> >   	v4l2_async_nf_cleanup(&csi2rx->notifier);
> >   	v4l2_async_unregister_subdev(&csi2rx->subdev);
> > +	v4l2_subdev_cleanup(&csi2rx->subdev);
> >   	media_entity_cleanup(&csi2rx->subdev.entity);
> >   	kfree(csi2rx);
> >   }
> >=20
>=20

--=20
Thanks,
Jai

GPG Fingerprint: 4DE0 D818 E5D5 75E8 D45A AFC5 43DE 91F9 249A 7145

--gssmw375yvf33hoq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEETeDYGOXVdejUWq/FQ96R+SSacUUFAmTLjPAACgkQQ96R+SSa
cUW0fRAAyurEvnRJ5VdpYKVyY75cTcPb0kwjetlScNCRkjaZSZ0aIakv6cirD+X6
rpK9kNwRTxRZ6ybe4fcuWYATcAEhYZCPX4AYuSFD3tSL0IX5XniBSlD8M8tTKMN+
VP1LXIksD73W1hksEiSUtpbvUQtv7C1W+x7+LEKcxMpxv6+/Fqk7e6Ti7d3Nkj7G
9xzjTlDTPnPnfBQMTScwPqVrI07WiruqxO7QYqGgT8siLVHUdHgiAohqwoCM5pyr
+ib6UYYX8aQQChyKNX0d/lN3r9MntvpHRQLvt+XDPvWVSPDeC0LD5bw7B3tnoD9e
K2raVxl2WnRfzjOjtX/Rl/ACKi4gAUNmnQ+yDTcyqmmvju1/RS3m64NdLQNfNitH
wbuphJFMEK1MxhTjULd/iQBiypzFiKPCKxMFZjmNKq/WqnPwxH89K+STt3lcSw6O
UHtg9+/NtlkUvaSRnGMFFKfhvsOgzNyTWGKood9/SAAdtT5T9tteMqPK67ZIrNwi
914N1x+pPlWIZrP4M/bNEm0JeTtjNe7dJGidgXxbeis8bbRJflxVV1Kdj5ZWDJ5u
xt4XtT0TIpnlyj52QuMrYHKYeIi5leZMa+XI6K6niow048GvOnLtB09EH4jo95K1
YrlNaLPCXULNxrzdYoBgYizkpLrtvDtDH33mJtZ7URv7VXaTyZs=
=A5kV
-----END PGP SIGNATURE-----

--gssmw375yvf33hoq--

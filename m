Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37D6578350D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 23:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbjHUV6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 17:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbjHUV6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 17:58:37 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F733129;
        Mon, 21 Aug 2023 14:58:35 -0700 (PDT)
Received: from pendragon.ideasonboard.com (aztw-30-b2-v4wan-166917-cust845.vm26.cable.virginm.net [82.37.23.78])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id F0AEB6D5;
        Mon, 21 Aug 2023 23:57:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1692655037;
        bh=VMSPjv2DqGuGsHsm746vd5bo2vG27BOcjVtyo3EUlKA=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=sfe0FVG6n0ULilznKrPzLdYEwDIDhLlRdtXB5qXOWLfUDSvEfYhmL/6A/MiI5LfU7
         I7PEd6olEnvLl+Wt5ZzO4TVg3evrWZT/+IZYXDav/LZqsnYhgwBw9lxymu9WSw2rT/
         UDQDzg88j+JQWFx5PWSM04TJvpbsVKZH5+mjXCSI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230816105642.20419-1-wsa+renesas@sang-engineering.com>
References: <20230816105642.20419-1-wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH] drm: renesas: rcar-du: use proper naming for R-Car
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org
Date:   Mon, 21 Aug 2023 22:58:30 +0100
Message-ID: <169265511004.435850.5466517142137717153@ping.linuxembedded.co.uk>
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Wolfram Sang (2023-08-16 11:56:41)
> Not RCAR, but R-Car.
>=20
Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/gpu/drm/renesas/rcar-du/rcar_du_plane.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_plane.h b/drivers/gp=
u/drm/renesas/rcar-du/rcar_du_plane.h
> index f9893d7d6dfc..e9e59c5e70d5 100644
> --- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_plane.h
> +++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_plane.h
> @@ -16,7 +16,7 @@ struct rcar_du_format_info;
>  struct rcar_du_group;
> =20
>  /*
> - * The RCAR DU has 8 hardware planes, shared between primary and overlay=
 planes.
> + * The R-Car DU has 8 hardware planes, shared between primary and overla=
y planes.
>   * As using overlay planes requires at least one of the CRTCs being enab=
led, no
>   * more than 7 overlay planes can be available. We thus create 1 primary=
 plane
>   * per CRTC and 7 overlay planes, for a total of up to 9 KMS planes.
> --=20
> 2.35.1
>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFD39787EB6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 05:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239897AbjHYDoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 23:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238095AbjHYDo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 23:44:29 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC361BD4;
        Thu, 24 Aug 2023 20:44:26 -0700 (PDT)
Received: from pendragon.ideasonboard.com (unknown [95.214.66.65])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 12703DA8;
        Fri, 25 Aug 2023 05:43:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1692934985;
        bh=rKTzwYto2986XAPKWYdldpSToCtbqK/Es8+SktCphd8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uSVpK1hmPCSB0HXGw9I/8e5BlsfhHF6V3xeAqpIyRR1lpDr3aWD5+vO2wLLqpYJn2
         PCg35Qy2JACbvVXLLRjGYSV+w5OJstrc3uHBnuhHGfhL+zcwykmTi+59c1zVi2Yu4u
         IKuNXvG3Rq51o7Nnth7rPUcKo9hVVf15SUAZY/lk=
Date:   Fri, 25 Aug 2023 06:44:30 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Jai Luthra <j-luthra@ti.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        niklas.soderlund+renesas@ragnatech.se,
        Benoit Parrot <bparrot@ti.com>,
        Vaishnav Achath <vaishnav.a@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>, nm@ti.com,
        devarsht@ti.com, a-bhatia1@ti.com,
        Martyn Welch <martyn.welch@collabora.com>,
        Julien Massot <julien.massot@collabora.com>
Subject: Re: [PATCH v9 02/13] media: dt-bindings: cadence-csi2rx: Add TI
 compatible string
Message-ID: <20230825034430.GE6477@pendragon.ideasonboard.com>
References: <20230811-upstream_csi-v9-0-8943f7a68a81@ti.com>
 <20230811-upstream_csi-v9-2-8943f7a68a81@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230811-upstream_csi-v9-2-8943f7a68a81@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jai,

Thank you for the patch.

On Fri, Aug 11, 2023 at 04:17:24PM +0530, Jai Luthra wrote:
> Add a SoC-specific compatible string for TI's integration of this IP in
> J7 and AM62 line of SoCs.
> 
> Reviewed-by: Maxime Ripard <mripard@kernel.org>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Jai Luthra <j-luthra@ti.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  Documentation/devicetree/bindings/media/cdns,csi2rx.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/media/cdns,csi2rx.yaml b/Documentation/devicetree/bindings/media/cdns,csi2rx.yaml
> index 30a335b10762..2008a47c0580 100644
> --- a/Documentation/devicetree/bindings/media/cdns,csi2rx.yaml
> +++ b/Documentation/devicetree/bindings/media/cdns,csi2rx.yaml
> @@ -18,6 +18,7 @@ properties:
>      items:
>        - enum:
>            - starfive,jh7110-csi2rx
> +          - ti,j721e-csi2rx
>        - const: cdns,csi2rx
>  
>    reg:
> 

-- 
Regards,

Laurent Pinchart

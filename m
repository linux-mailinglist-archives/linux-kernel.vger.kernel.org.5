Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33E497A77E8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 11:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234212AbjITJsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 05:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234185AbjITJsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 05:48:09 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E42FA3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 02:48:01 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 88E671C000B;
        Wed, 20 Sep 2023 09:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1695203280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IA4WLlvkMqmNqXdDac+G3m7vIHHqX9F+9GNYax6y8fQ=;
        b=hi72pEcK8zlBRyl0qdUKn8ZHmrqcOtfMLeRBbBed39s64kYU67R6UyQs/bGo/FQXU1oCdf
        4l/hBylRcSsvBsRH5SGb2TVnHyGg4R6UvPIde+Cw64loJyFs7fVx2D6l4w9BwaoA2iQDIB
        4BsAKr3cRdfd2knz9nykrVR7C9acgiypp3JIMwLxmySOmcdm9EWPXW5EiokrWeS6aeM5F9
        CWhJX8Itvnkb2eupAHa+cvYvh1/o3fy0DO5Bz1gXVyp9dssI1H+XRUwLTm+bZTGcdsKZnr
        yJsF72x6O85zDKu5NvapmGJvfgl27jAO+XxZvc0MjhyvIOCGtC+g8xOpquV6+w==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Robert Marko <robert.marko@sartura.hr>, andrew@lunn.ch,
        sebastian.hesselbarth@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     luka.perkov@sartura.hr, Robert Marko <robert.marko@sartura.hr>
Subject: Re: [PATCH 2/2] MAINTAINERS: uDPU: add remaining Methode boards
In-Reply-To: <20230914095236.1601639-2-robert.marko@sartura.hr>
References: <20230914095236.1601639-1-robert.marko@sartura.hr>
 <20230914095236.1601639-2-robert.marko@sartura.hr>
Date:   Wed, 20 Sep 2023 11:47:58 +0200
Message-ID: <87bkdxfa5t.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: gregory.clement@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Marko <robert.marko@sartura.hr> writes:

> Methode also has eDPU which is based on uDPU, so add eDPU as well
> as the common uDPU DTSI.
>
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>

Applied on mvebu/fixes

Thanks,

Gregory
> ---
>  MAINTAINERS | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e0c4cf40cbb8..5bec4bcf8386 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13875,7 +13875,8 @@ F:	drivers/staging/media/meson/vdec/
>  METHODE UDPU SUPPORT
>  M:	Robert Marko <robert.marko@sartura.hr>
>  S:	Maintained
> -F:	arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
> +F:	arch/arm64/boot/dts/marvell/armada-3720-eDPU.dts
> +F:	arch/arm64/boot/dts/marvell/armada-3720-uDPU.*
>  
>  MHI BUS
>  M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> -- 
> 2.41.0
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com

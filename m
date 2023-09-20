Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30FB97A77E7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 11:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234196AbjITJrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 05:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234190AbjITJrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 05:47:49 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39053E5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 02:47:41 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id C50AAC000F;
        Wed, 20 Sep 2023 09:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1695203258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KBMJgzR8VAF5Tv49FJwXsEieKkO/KF/zP4P1pWbF3QI=;
        b=D6zZpFJjRJP4kcKIdstlMhQTixcG8o/ZnAzvvG4N/thpkp9V4+LgaIfndEnRJtrrmT04/T
        kV6omv2joTkvFisnannvxB81iHhFkxjshJoFkdogs6I375rbAgo1+mzkNyTzo0PoGjEp0m
        hAQHcvIeqkJhgzWXmPC+xx7dUXycYlyF0l3QBtXgP3FCjEaCa3eRvY1cX0p2GnilJqv3Zh
        kStJ0kJDhy4KgtpFtMAQdIU3F7MrZnkVzgFb+myqQ8WWO8LEnS/3KKkvjdqczUCMsgJjKd
        u8KIK5zYY/ibKmr9iLixP2NKyOAq6RDJWMrV0NwXFQhkjPVO5SYq/CvfKcLHHA==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Robert Marko <robert.marko@sartura.hr>, andrew@lunn.ch,
        sebastian.hesselbarth@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     luka.perkov@sartura.hr, Robert Marko <robert.marko@sartura.hr>
Subject: Re: [PATCH 1/2] MAINTAINERS: uDPU: make myself maintainer of it
In-Reply-To: <20230914095236.1601639-1-robert.marko@sartura.hr>
References: <20230914095236.1601639-1-robert.marko@sartura.hr>
Date:   Wed, 20 Sep 2023 11:47:37 +0200
Message-ID: <87editfa6e.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: gregory.clement@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Marko <robert.marko@sartura.hr> writes:

> Vladimir is no longer at the company, so I am stepping up to maintain the
> Methode boards.
>
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>

Applied on mvebu/fixes

Thanks,

Gregory
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fa7487b7729b..e0c4cf40cbb8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13873,7 +13873,7 @@ F:	Documentation/devicetree/bindings/media/amlogic,gx-vdec.yaml
>  F:	drivers/staging/media/meson/vdec/
>  
>  METHODE UDPU SUPPORT
> -M:	Vladimir Vid <vladimir.vid@sartura.hr>
> +M:	Robert Marko <robert.marko@sartura.hr>
>  S:	Maintained
>  F:	arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
>  
> -- 
> 2.41.0
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com

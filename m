Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECEE80A6FF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 16:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574323AbjLHPNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 10:13:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574331AbjLHPMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 10:12:46 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8781E2102;
        Fri,  8 Dec 2023 07:11:54 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id A627C240013;
        Fri,  8 Dec 2023 15:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1702048313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jZUfjZrEUjnspuhceJ7+ctQJ1wXG1XV3mAd4MZs0sqI=;
        b=KO/hg7qC/HGdIVC0A02sNFqeNiYVqLtoVRYZilg2VukX1cOofO5cBzk1mJWHW6AffXnnbB
        Zjf4szZCnK5eOJlk+uMAxS2To+caXTjHVAAuTlYwr5s3ew/uZJaqLfo51lOo04TrJa10LN
        cpVRcpN7rokxtyWki3tgoBWnlKW8LeIzdgbWNfd4fDntGpv6EA6ofg3DglkAHK/JEJ1HNy
        YhocJ8a3EDMl6Tp4gxtjBzJQPw/kvwmtmcCJx73Uwz+yBSxI29gPGzR3GJ8HNbsL18qCHo
        d9CYgypTkLo/oWoOPoaNgO5rU+VqlUuEL8qzcr8hZjF7lTx81VrhN4nTnG/zTg==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v9 3/3] ARM64: dts: Add special compatibles for the
 Turris Mox
In-Reply-To: <20231127-mv88e6xxx-mvebu-fixes-v9-3-d19b963e81fb@linaro.org>
References: <20231127-mv88e6xxx-mvebu-fixes-v9-0-d19b963e81fb@linaro.org>
 <20231127-mv88e6xxx-mvebu-fixes-v9-3-d19b963e81fb@linaro.org>
Date:   Fri, 08 Dec 2023 16:11:52 +0100
Message-ID: <874jgsenk7.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: gregory.clement@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Walleij <linus.walleij@linaro.org> writes:

> These special compatibles are added to the Marvell Armada 3720
> Turris Mox in order to be able to special-case and avoid
> warnings on the non-standard nodenames that are ABI on this
> one board due to being used in deployed versions of U-Boot.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Applied on mvebu/dt64

Thanks,

Gregory
> ---
>  arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com

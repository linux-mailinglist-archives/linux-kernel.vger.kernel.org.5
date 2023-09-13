Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4C379F3F9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 23:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbjIMVqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 17:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232800AbjIMVqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 17:46:42 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D977198B;
        Wed, 13 Sep 2023 14:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=pxR15M8m/2jQvnaKDy+BPuzL4T3YF99oD14Zf47np38=; b=Mr6D63mKVH8NczbhL9tkCUyxux
        A+b1D8qAjfSU317ZnsjIXoMj+spxJyMBltkXRZsMxzlVcNQ4B2+Xrr6yKuTh/b2xrQS7BBfluObbZ
        NeNKhNS/+8SfYcadZngjmQW59heY0uAE6odYTVRriO6r/6zTGzy9O4UkAfzx9LwZQ4hA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qgXgm-006LM2-K6; Wed, 13 Sep 2023 23:46:24 +0200
Date:   Wed, 13 Sep 2023 23:46:24 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        Arun Ramadoss <arun.ramadoss@microchip.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        UNGLinuxDriver@microchip.com,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v4 1/2] dt-bindings: net: dsa: microchip: Update
 ksz device tree bindings for drive strength
Message-ID: <daa063e8-d245-4b67-be2c-c67c16ddb36b@lunn.ch>
References: <20230912045459.1864085-1-o.rempel@pengutronix.de>
 <20230912045459.1864085-2-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912045459.1864085-2-o.rempel@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 06:54:58AM +0200, Oleksij Rempel wrote:
> Extend device tree bindings to support drive strength configuration for the
> ksz* switches. Introduced properties:
> - microchip,hi-drive-strength-microamp: Controls the drive strength for
>   high-speed interfaces like GMII/RGMII and more.
> - microchip,lo-drive-strength-microamp: Governs the drive strength for
>   low-speed interfaces such as LEDs, PME_N, and others.
> - microchip,io-drive-strength-microamp: Controls the drive strength for
>   for undocumented Pads on KSZ88xx variants.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

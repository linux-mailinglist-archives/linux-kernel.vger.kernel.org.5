Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 569977AE33D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 03:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232742AbjIZBRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 21:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbjIZBRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 21:17:04 -0400
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8204510A;
        Mon, 25 Sep 2023 18:16:58 -0700 (PDT)
Received: from [192.168.68.112] (ppp118-210-175-231.adl-adc-lon-bras34.tpg.internode.on.net [118.210.175.231])
        by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 1045A20174;
        Tue, 26 Sep 2023 09:16:54 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeconstruct.com.au; s=2022a; t=1695691016;
        bh=pI7CpauyPvWTw3RXV9voYlIonvIp7u1XGUeBxrYew7g=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References;
        b=LapCsNJvU8+qScB5n4biG3vEM+WDKp0NrKLUDi3zSteIjhq43dKWIg650C95eErt1
         gAjj1edkYNy9IHoaKcqsVOC0jJGkoCSdPKWNBiTqyL36niTsbGGdX+UjeioZcwlCGj
         K0IMXNtOZeWtdPN3rTh2yGWRWa4Bv0podRoG79SPlGOicsxsCWTIq84U9en+HZk/wB
         kUNSSo4k0rAwMXbbyPx/YQovhQLMcslmAz4YOzIVKryzPp3b5FB3trUZI0etkTchXo
         mt9pfCJNdn/P7a+oFKICIqzUcwg6dVvchxyMqYeFuR5ICN38DeW0bU1itBG0hQCWsS
         WfS/UYg9t3/EQ==
Message-ID: <e3c4013eca1b7cb6edd6724be37e2ec86fc408dd.camel@codeconstruct.com.au>
Subject: Re: [PATCH] pinctrl: pinctrl-aspeed-g6: Add more settings for
 USB2AHP function
From:   Andrew Jeffery <andrew@codeconstruct.com.au>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Joe Wang <joe_wang@aspeedtech.com>
Cc:     linux-aspeed@lists.ozlabs.org, andrew@aj.id.au,
        openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, joel@jms.id.au,
        linux-arm-kernel@lists.infradead.org
Date:   Tue, 26 Sep 2023 10:46:54 +0930
In-Reply-To: <CACRpkdaZb+V-Zx_Uw9MCqRqE+N-0gd__xEFV3BTpkG7icU9W+A@mail.gmail.com>
References: <20230920103332.274151-1-joe_wang@aspeedtech.com>
         <CACRpkdaZb+V-Zx_Uw9MCqRqE+N-0gd__xEFV3BTpkG7icU9W+A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-09-25 at 15:15 +0200, Linus Walleij wrote:
> On Wed, Sep 20, 2023 at 12:33=E2=80=AFPM Joe Wang <joe_wang@aspeedtech.co=
m> wrote:
>=20
> > AST2600 USB2AHP (USB PortA: PCIe EHCI to PHY) function needs to set the
> > register SCUC20[16]. Set it to enable the PCIe EHCI device on PCIe bus.
> > Besides, also add USB2AHP signal expressions into pin declarations.
> >=20
> > Signed-off-by: Joe Wang <joe_wang@aspeedtech.com>
>=20
> Patch applied!

Thanks. I hope to improve my review responsiveness for Aspeed patches
over recent times.

Andrew

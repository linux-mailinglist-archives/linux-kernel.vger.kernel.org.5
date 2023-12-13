Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09BE280FBAA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 01:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377606AbjLMAAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 19:00:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232624AbjLMAAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 19:00:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82066BE
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 16:00:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C07BC433C8;
        Wed, 13 Dec 2023 00:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702425643;
        bh=P4ZmKF2m1aszLr/cpUggGxXzp94xFrO2iZjJ8pMqg+E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rr+8sXVaCR0cZJfv25f5QiVFngRPZpU9NmLl4uCO7WxxK3BPCXWN1Wh+LmpLBBu2a
         ClLlVD7V0O5cpv+vf6COEK3i6JxOcNQyV0Dnixbb7Xb5cWW5u4fY0ICqclW2zB1DGN
         3e/DE0Mkib942xdPVP+h0rZ/bkRQiBfy17+afZz67kdJDPRhEt/JIPT0lQQCgn0dQO
         q7oc2gvw17TkeossVqF6P4nUL0UyfHPd0Z6cn5zvBMS8S3Bo7VTmIjQTSF3oIbjV7h
         vwGtq/DqUKlSMsfBSA4VS0yTlCtaKUYrk/yN0YD6rzwi0hZhROXhX9nFATIMhKDzAp
         S1J94Ehdjyoxw==
Date:   Tue, 12 Dec 2023 16:00:41 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Herve Codina <herve.codina@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 0/5] Add support for framer infrastructure and PEF2256
 framer
Message-ID: <20231212160041.59c93d8a@kernel.org>
In-Reply-To: <CACRpkdYT1J7noFUhObFgfA60XQAfL4rb=knEmWS__TKKtCMh7Q@mail.gmail.com>
References: <20231128132534.258459-1-herve.codina@bootlin.com>
        <CACRpkdYT1J7noFUhObFgfA60XQAfL4rb=knEmWS__TKKtCMh7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Dec 2023 23:15:38 +0100 Linus Walleij wrote:
> here is an immutable tag for the PEF2256 framer, as promised.
> 
> I have already merged it into the pinctrl tree for starters.

Pulled to net-next as well, thank you!

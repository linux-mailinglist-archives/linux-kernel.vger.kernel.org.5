Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2077ACEBA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 05:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjIYDeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 23:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjIYDeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 23:34:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FCDCC2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 20:34:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2605C433C7;
        Mon, 25 Sep 2023 03:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695612840;
        bh=U53U9H5MRNk5Ao2xW1Myg5M29nlgRmanL1dz8BY/Pvg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kwUil0biMAXdvV4HZfgrBoLk0cyZlneRMrldd+hCdrz2dOEa81WFgyLsxxPIvNrz2
         SJw9dv7wY6xJx/UB6sVbqcBGjrlH+pQ9HyfdzojiI6KGd22QkroU00z41HzyrDK4gg
         EINMWWyAEr8pY6pBrmGasWVPtwNBJi/2xjqLZ2tb/T9ZrLThe8Ar72lzEdCAg1QDzy
         Js/GE4B2DtBcj5owiWxSqOUP88csbF6BnCJXisPzfCFFXbwTDiYAX4iMaZmErTnq4S
         KaBLSEr+B92RH8eHJfMkVTha79YS4RhxHKYEXWMS7pwLlTJuMRxyyQ+NNebE18Ilro
         SU1EuXgGs7mOw==
Date:   Mon, 25 Sep 2023 11:33:44 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     James Hilliard <james.hilliard1@gmail.com>
Cc:     devicetree@vger.kernel.org,
        Pierluigi Passaro <pierluigi.p@variscite.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marek Vasut <marex@denx.de>,
        Tim Harvey <tharvey@gateworks.com>,
        Stefan Wahren <stefan.wahren@chargebyte.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Li Yang <leoyang.li@nxp.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v9 1/3] dt-bindings: arm: fsl: Add VAR-SOM-MX6 SoM with
 Custom Board
Message-ID: <20230925033344.GH7231@dragon>
References: <20230921055611.1459374-1-james.hilliard1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921055611.1459374-1-james.hilliard1@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 11:56:06PM -0600, James Hilliard wrote:
> Add support for Variscite i.MX6Q VAR-SOM-MX6 SoM with Custom Board.
> 
> Cc: Pierluigi Passaro <pierluigi.p@variscite.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Applied all, thanks!

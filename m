Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8571F7685C0
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 15:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjG3NpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 09:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjG3No7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 09:44:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21496E66;
        Sun, 30 Jul 2023 06:44:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1A5160C7D;
        Sun, 30 Jul 2023 13:44:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84EB3C433C8;
        Sun, 30 Jul 2023 13:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690724698;
        bh=1D42diIQ7tPAn5Xqu6R06rKruNPy5NBp4jWplaHhaUk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WwkzlD0tx8swWh8XQ7JLYbwXJqU5Q6JmI1opFSGdXjHhNKDPKstoxA+o2v7W0I3Ai
         r+Fr+EwcENDjZuhraE/SnOm6h0GZ7rkR0E4v4zUcWaROifkkp+6QAhzLNK7BZKNo1H
         PbHdYqL2BqeGiyXlPaz0Mnc7lDqqQPBn192JkjBz/AYO06l0vtg7i6c2yT97xljwNz
         TJiS4g/cHLJxCDaN1546hEV7RNQEDXFG14S2dEXhrfi2mQHV55ONRpfGWrwS1edT62
         YQF4elg2UKChSk9ajBumZm+VQi8G4oFIhKElV6WOSrEl3xbyzZGzfIsWppMyo890sN
         yuhHQiFw55H4g==
Date:   Sun, 30 Jul 2023 21:44:46 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 1/8] AMR: dts: imx6sx-nitrogen6sx: drop incorrect
 regulator clock-names
Message-ID: <20230730134446.GV151430@dragon>
References: <20230726070322.103871-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726070322.103871-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 09:03:15AM +0200, Krzysztof Kozlowski wrote:
> regulator-fixed does not take "clock-names" property:
> 
>   imx6sx-nitrogen6sx.dtb: regulator-wlan: Unevaluated properties are not allowed ('clock-names' was unexpected)
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Fixed the typo of 'AMR' in subject of 1/8 ~ 4/8 (Thanks Fabio!), and
applied all, thanks!

Shawn

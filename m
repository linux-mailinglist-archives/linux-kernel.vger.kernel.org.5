Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32B17758DD0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 08:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbjGSGcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 02:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbjGSGcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 02:32:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0B2127;
        Tue, 18 Jul 2023 23:32:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D01461032;
        Wed, 19 Jul 2023 06:32:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16A91C433C8;
        Wed, 19 Jul 2023 06:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689748368;
        bh=/3m2wb1UgJDM6N8EOfefcV0pDZGTUQ51FBiTnMW1eq4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TefBMJ6K/DEoVAINXOc4t1FIcuRGoyhWIqKEcE5JsJ1aYzi9dfq1w7I6XYqIpoHbT
         HpmyvqFKCSKk4yyIEcE73NUd5psQLrRKcsif9MJ6KmbCgXrnNiJtTEzUpUYUvoQP06
         rgHYLOxZ4q5x3KakFRnPgr+gOdLTqKIRvuinzAdtGyf+rDBHSATPv/wG2UMJjs7FFn
         CD4TgPMBvKotvOUJlRX9DU4B5+AIRSbx4k4ZY6PCj0A3PeuxoGDcl0aCy+gGoTFWgQ
         DMghqCMO3qptbCj+PX0sUhVbjzkDbQTzCLBLau3CWZhYe9t1q+6BqqNug76ydfGXH7
         mJzi5OaIZm79w==
Date:   Wed, 19 Jul 2023 14:32:36 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: imx1-apf9328: correct ethernet reg addresses
 (split)
Message-ID: <20230719063236.GD151430@dragon>
References: <20230713152946.82938-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713152946.82938-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 05:29:46PM +0200, Krzysztof Kozlowski wrote:
> The davicom,dm9000 Ethernet Controller accepts two reg addresses.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied, thanks!

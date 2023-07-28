Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A9F7662BE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 06:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233310AbjG1EGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 00:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233250AbjG1EFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 00:05:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B6330E3;
        Thu, 27 Jul 2023 21:05:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 139E961FBA;
        Fri, 28 Jul 2023 04:05:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8274C433CA;
        Fri, 28 Jul 2023 04:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690517150;
        bh=+oTYmEDdqfkvKgeJz/RPs09HyIiqWtkgzKBg1zlaVmk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pFPSrbwTj8weKvOqheBefTVoXSWJlqvEGbEYNROtW9wZ+9unDQuZqEWMap+ZbqwCL
         5rLiZB0ysJYHwI1A9+plfIkWMzpccBdEdO4RKbVITlC++5G3C0weSxsNb1mfZgcN0j
         rOaEtjhjpL7x/cEBdhUG+rlXUNshDnDS48EiLjGjEzExk8E99qOui35qqQr4fRPkza
         /SiMS/GrvoZDxcudkfjOQg51BbMCud8TzEdbpteM43btB8qF+MORdv6LkqS9QGDFsW
         9XJeJg2CajGrnsr7kZbBLTL3azeLJhR7YEqY4ldC6JsTE5Qjhn1M6yCVsEgKjXD40S
         yGt0/hEamhJTQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: msm8939-samsung-a7: Drop internal pull for SD CD
Date:   Thu, 27 Jul 2023 21:08:55 -0700
Message-ID: <169051733321.1270972.3724054135534207682.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230723-a7sdc2cdnopull-v1-1-699fd730afcb@gerhold.net>
References: <20230723-a7sdc2cdnopull-v1-1-699fd730afcb@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 23 Jul 2023 12:54:41 +0200, Stephan Gerhold wrote:
> A7 seems to have external pull-up for the SD card chip detect (like
> most MSM8916/MSM8939 devices) so drop the internal pull-up. It's not
> necessary.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: msm8939-samsung-a7: Drop internal pull for SD CD
      commit: ee0e92b8e7b5894daf5c94e6433a1989f7233fbe

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

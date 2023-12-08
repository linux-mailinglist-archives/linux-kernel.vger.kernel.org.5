Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D41F8099EF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 03:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573171AbjLHCzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 21:55:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573033AbjLHCyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 21:54:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C341986
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 18:53:50 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A71BC433CA;
        Fri,  8 Dec 2023 02:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702004030;
        bh=9+KJFxdoKYDTu22BXc01HrvoWCaUK4XIkr5l2WnuW6Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iC92HtPtScSiHFchv8KrH4YHKpyRfJSrBX1kSLBz3R78bWO8klHAxn81p+jHS9rKz
         Odpn8A+f/tyvejbJamXVFjtRNohIx6wvCxJkIg2UWNk77upKs5yviCNcJ5pxF3Cjq9
         IlQppEjYCbO4LeBw+cyK07XZpT6u3OCtLZ7vZJw001gCeKVhOsNos4NPeTd53gXW/0
         gOcXK2ATlI7zZaQYepspWB7bTSGCKPD76M07AkDLp/buimJggotIeSmIrGSjyBfROx
         8kwcnMZKQ/Tdu6oFB8VuQ8Me4UaWzbwk1wUR7spYVvl8vx/r7A/64CvkxIX06Rl8gV
         h/Xz82fP/O9fQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Steev Klimaszewski <steev@kali.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: qcom: sdm850-lenovo-yoga: Add wakeup-sources
Date:   Thu,  7 Dec 2023 18:57:54 -0800
Message-ID: <170200426917.2871025.5231620499105502810.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107-wakeup-source-v2-1-bf1562ef9367@kali.org>
References: <20231107-wakeup-source-v2-1-bf1562ef9367@kali.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 07 Nov 2023 23:17:10 -0600, Steev Klimaszewski wrote:
> The keyboard and touchpad can be used to wake the machine
> up from sleep, so mark them as such in the dts file.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sdm850-lenovo-yoga: Add wakeup-sources
      commit: fdcc36cda04114878f6c752083669719a3995fce

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F12C8020F2
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 05:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233219AbjLCEwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 23:52:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233147AbjLCEwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 23:52:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9282C172E
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 20:51:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19658C433C7;
        Sun,  3 Dec 2023 04:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701579117;
        bh=Z0DBXWpSWjalDvBwoh4YHwldMBRWEXr5tco2zGQynJ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U+iRQnquVyhrO+L6fOXKdo1ph1rAq1ULfvlXsW0LaZ0yxobNhck79QpcVnz8wIonx
         DJjAllJM4TKxuRqQ0kCh+a5l85NtfOB7SNuE8+Nb40YaHGJBqHw3tCAIra0DrB3owH
         WIIDTqio5rCV/jXF4hbY+HXxDXUP3U/UJ2ZEwtcq8wRtEz1w17P3a/lEWjgtJQNQ6/
         tF2a1xUaSzCFo/9A2QCLkPuCMkWmzGuC/5bsX2XhlvBfwg8lMGB/f0aNbEkevwAT1m
         YsxdCeHEvvTCsCLqeD/YLZEiIfGRYQepQ762/q2MtCjBipAwW2xP/Uf0fVbuWowgG9
         oxeL2kL7nJiUA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jianhua Lu <lujianhua000@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: (subset) [PATCH v3 1/2] arm64: dts: qcom: sm8250-xiaomi-elish: Fix typos
Date:   Sat,  2 Dec 2023 20:54:44 -0800
Message-ID: <170157925820.1717511.16661964218018825273.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231126022849.14273-1-lujianhua000@gmail.com>
References: <20231126022849.14273-1-lujianhua000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 26 Nov 2023 10:28:48 +0800, Jianhua Lu wrote:
> There are two typos in this dtsi, so fix it.
>   classis -> chassis.
>   80700000 -> 80600000
> 
> 

Applied, thanks!

[1/2] arm64: dts: qcom: sm8250-xiaomi-elish: Fix typos
      commit: 608168b4d6079f2c43944bdfd64fd6c405d9a767
[2/2] arm64: dts: qcom: sm8250-xiaomi-elish: Add pm8150b type-c node and enable usb otg
      commit: 69652787279d64b0b0cc350fdfb34c503e40653c

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

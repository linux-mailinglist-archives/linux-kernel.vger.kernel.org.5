Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EADEB77B020
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 05:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232910AbjHNDZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 23:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232752AbjHNDZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 23:25:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD182E62;
        Sun, 13 Aug 2023 20:25:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B0B1628D1;
        Mon, 14 Aug 2023 03:25:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B058C433C8;
        Mon, 14 Aug 2023 03:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691983505;
        bh=RSpFO0lwpuWpT0527hFOfo0LcxBNEmIphv+kESel0t0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hcd02FQO0ecw1STkIWmTqqqsdQaaksoC1+O2NQyigt1/vvP1U+BPpvZbjCDwrg5H+
         XcWbzHzK+JSHEAipztOvKdzXXNwzVzqk7P7k35AtZoHoNAX3XzYZ/wGM2N+/gduySM
         aX3lvaY0cJbgIRET9q83CIiTHNEzb4U5xNkBQhVUJCVh1pyz+pnVRJ0Zj4fmzzxzG1
         1BQ3zdHP0B+KoWbZr3qANSjg314Ptw4aXX0ZHJlJebOdFiAzvF1R1FBlKPSa59ZC94
         nAZ/2KNU8zudb8TCF1w5NJoApvy5ZYDuY068H2UJBHLMrc2tsUS7xf8C82k46EYqhg
         GgXkWL7nXo4Uw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] arm64: dts: qcom: msm8998: Add DPU1 nodes
Date:   Sun, 13 Aug 2023 20:27:36 -0700
Message-ID: <169198364314.2443702.1603468742708590795.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230805-topic-8998_dpu-v1-1-9d402dc1ecc0@linaro.org>
References: <20230805-topic-8998_dpu-v1-1-9d402dc1ecc0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 05 Aug 2023 14:26:44 +0200, Konrad Dybcio wrote:
> Add the required nodes to support the display hardware on msm8998.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: msm8998: Add DPU1 nodes
      commit: ff88e1c9dd8cbdbf5487a0e807866049cc5bb4d9

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

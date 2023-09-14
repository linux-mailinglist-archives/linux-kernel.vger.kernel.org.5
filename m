Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12C557A0A08
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 18:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241482AbjINQAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 12:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241396AbjINQAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 12:00:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5130F1FD2;
        Thu, 14 Sep 2023 09:00:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43D58C433CA;
        Thu, 14 Sep 2023 16:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694707236;
        bh=s03MGFQBL0QBju8gHOwhnm7b8DWId+2tVRQJS/iUXnY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dPVVmqmCN63HSGnyuDOfrzvWPDWOmAbfgciw8Mbgts0IWth0iLMsA/LK+EOvdVTh3
         U3bj/kj+TCLLORubXKvPytR1Bc5gatZsfrazZmQLbz4xWoxSl8VbQA+OjkxvZ36ktx
         zlxRmhGMCVB/0uWT4zDloBt8WsEIxe9LzwCWbip6r7BUt6hmseae0MahFArOjTtqok
         ZLDpQBOBn36d2B8tD0PUd4TaORvVv/nUkJB2XYPNXPjjbZNVijU9vdrDgXMDsy1EW/
         JySavq2mz7SqYO9+xDp0kkq4o5GSN9Eb+HlzTqTW2hIEGAIEVJE9k5W89XuQZ594Qt
         t+d9+699DT38Q==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sm8250-edo: Set UART alias and stdout-path
Date:   Thu, 14 Sep 2023 09:04:23 -0700
Message-ID: <169470744883.681825.16969162035585041637.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230912-topic-edoconsole-v1-1-b392ea67e539@linaro.org>
References: <20230912-topic-edoconsole-v1-1-b392ea67e539@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 12 Sep 2023 15:48:31 +0200, Konrad Dybcio wrote:
> The GENI UART driver requires one specifies a numeric alias. Do so and
> set the stdout-path to route the console to the debug uart in the microSD
> slot by default.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sm8250-edo: Set UART alias and stdout-path
      commit: 2e754956848889d5b04d8023753fa28de679373d

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

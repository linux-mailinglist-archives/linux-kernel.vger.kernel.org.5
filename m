Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8647E7D23B7
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 17:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbjJVPq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 11:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbjJVPqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 11:46:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C60FF7;
        Sun, 22 Oct 2023 08:46:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C9E9C43397;
        Sun, 22 Oct 2023 15:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697989571;
        bh=KM1jYkXyTzK0guELYzlv7dUspsOjWBjpStn2Ayrrro0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q+S5QuC4+zia9Zl89xR6XEJkQtu0HrEfwuUpzMMz+KZwnfj4oKP10/i0l54pBwzbi
         a6ikST1jY6UX0/6opWaeyhb7GjJce5X8ZNNWH8vlOhVtCFmdwS3mPXA5WR6pZlxhLz
         5zln5T8qOp1rBjCEvceItQcHAut4vjxVO1rPpbdIK3eA23tnQ0kcsHQkV2zXDbiT1a
         CE1EJCwr8KpUTRWomH2AW5OhfhQwvn9wJj02Gr4beRmpicNSgk4eI1d5TIOdqxBD2v
         eGUxm5hzQIgKmjHmTgXLvoKgAmdflSsb4p6DxWuj0bRTXX0HQZEkd13C0JXMOt5xZx
         wNsD51X3mC7iA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Luca Weiss <luca@z3ntu.xyz>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Small style fixes in msm8974.dtsi
Date:   Sun, 22 Oct 2023 08:50:18 -0700
Message-ID: <169798982357.271027.2288868085918805203.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230627-msm8974-sort-v1-0-75c5800a2e09@z3ntu.xyz>
References: <20230627-msm8974-sort-v1-0-75c5800a2e09@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 27 Jun 2023 21:45:12 +0200, Luca Weiss wrote:
> While making sure the nodes are sorted correctly, I also noticed that
> some lines are wrongly indented. Fix both.
> 
> 

Applied, thanks!

[1/2] ARM: dts: qcom: msm8974: replace incorrect indentation in interconnect
      commit: 207f4ce365819ac68b634153d074252338d00ef6
[2/2] ARM: dts: qcom: msm8974: sort nodes by reg
      commit: 4960e06d386ecc5307bc2e66a77d5f06df1e2a6f

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

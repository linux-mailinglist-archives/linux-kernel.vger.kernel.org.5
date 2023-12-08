Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 499E380A63A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 15:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574207AbjLHOwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 09:52:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574200AbjLHOwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 09:52:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2CF0210B
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 06:51:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E519C433A9;
        Fri,  8 Dec 2023 14:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702047090;
        bh=wcbyHkeLmmTtwbMyq9TM9DIUmPz+UmC5BA0/+WGjbzQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K7IBMBxyVW8dkaGjdBic4E08DAH9fy/YbfGEH0ow81enP8ghl1ag7TOdF/X8Uxes0
         r9wLtHMKc9EfBV0e6utwxI+zFaYyWUUURrS+Qk4eDdbRDtCnXFFMaSaphvGcGFZ1M2
         usQ98I/t1vapEqhjtXGbwEe+CcLC8RcxZLU3s6zHfvsmiZShxlVNudqG9WA8n+Acvw
         0vPdV3UKufjO1nviJEh8r3ygt5pgFKiVZBT5e7Q2iRIHsQfqnVmWCx4BNdDtS2Cs+W
         YlavjxDVkPBpjZyP73zBeYzJd8km0YBa2Sq9xGHkSkiQqZ1umcAG+4IFZJkVetBB1v
         mlJBLPMNKohAQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: gpucc-sm8150: Update the gpu_cc_pll1 config
Date:   Fri,  8 Dec 2023 06:55:37 -0800
Message-ID: <170204733626.342318.18184910305785324276.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231122042814.4158076-1-quic_skakitap@quicinc.com>
References: <20231122042814.4158076-1-quic_skakitap@quicinc.com>
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


On Wed, 22 Nov 2023 09:58:14 +0530, Satya Priya Kakitapalli wrote:
> Update the test_ctl_hi_val and test_ctl_hi1_val of gpu_cc_pll1
> as per latest HW recommendation.
> 
> 

Applied, thanks!

[1/1] clk: qcom: gpucc-sm8150: Update the gpu_cc_pll1 config
      commit: 6ebd9a4f8b8d2b35cf965a04849c4ba763722f13

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

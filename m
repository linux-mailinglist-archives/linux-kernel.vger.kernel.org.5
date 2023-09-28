Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9B27B1010
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 02:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjI1AaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 20:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjI1AaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 20:30:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE29BF;
        Wed, 27 Sep 2023 17:30:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 006A8C433CC;
        Thu, 28 Sep 2023 00:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695861006;
        bh=8HtluV5jLpdAwDnUm4rU53vr0pQvMWbab4SsGNGI/28=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Cm/bTcnAd32yQGYxdqEjkp+3SrUmYwg6NjpW1P3BQtXoJgL6E2NUo0nqtO2CBNpKL
         qsFlOZ22Bj1EefYxOhayxc3KvjsEEfw2AksEIacNb3vs0UT4/4kTESqacMEkPcZ73O
         MZ7+PrA8ByPhxtbXCakYmbFW5dAXCZj2gALqZSe5aJGur8cGoupQBHd16aMMLUaIwk
         ahK98liYMRMIQ1m4pelQ38Ev5FU022ymsIK8xqjdoC1iut8Wy8hPs1QXCUsYCeJ/7r
         PJ9R1VeVufllU+kuwkZzdnsqf6IJNKlsY7TkTQJmt4LlM3wdvpSEY56EAI+pRKMxWf
         VTMi13JO/tUFQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@quicinc.com,
        Unnathi Chalicheemala <quic_uchalich@quicinc.com>
Subject: Re: [PATCH] soc: qcom: Switch to EXPORT_SYMBOL_GPL()
Date:   Wed, 27 Sep 2023 17:34:11 -0700
Message-ID: <169586125036.1226038.11477463747029420099.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230922184817.5183-1-quic_uchalich@quicinc.com>
References: <20230922184817.5183-1-quic_uchalich@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 22 Sep 2023 11:48:17 -0700, Unnathi Chalicheemala wrote:
> Switch to GPL version of EXPORT_SYMBOL for Qualcomm SoC drivers.
> 
> 

Applied, thanks!

[1/1] soc: qcom: Switch to EXPORT_SYMBOL_GPL()
      commit: 9b09c0f289c5a8fc5e9b0c1f3cd2766d33b910dc

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

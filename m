Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 914867A0A15
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 18:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241471AbjINQBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 12:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241430AbjINQAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 12:00:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B1E1FC0;
        Thu, 14 Sep 2023 09:00:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F39E3C433CA;
        Thu, 14 Sep 2023 16:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694707241;
        bh=B6U/t+00fMuZwDm+kv26dUg24hy4GQvLNVlJKlCEpbQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jGCS4Cvn31FUg0AXDJA/hNqhMrCeqc+Yfg+mwj8r2A/fZ3hag14yQ3+ODOKwRsMuk
         MUG+HDmYmlKXIPfgi5FpjuNETx3mXqmldoAZtrlkvk1IMAECsv11IuQeqfZZYvpzJJ
         OwqmNZvmOHswmHMXX0I9gcdRGH8pet4G9gpvc0YZg3zV/2EJu+unLM0qkFFXoIOjYc
         9/sDGxNPf4UxNgmCKBfkdnFxyBBDoqW5DzT2CAvjK9WraPXjbt5KkQJT3+0API9kLI
         6QLnJuHc/bd884Lj8gSWNwvXlumb5o9QMrh0ksO6ElBoJMjVzOujVLhzWHB2T5ycWR
         OiCUh2DCqRVZA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] arm64: defconfig: enable NB7VPQ904M driver as module
Date:   Thu, 14 Sep 2023 09:04:29 -0700
Message-ID: <169470744886.681825.7398135367540169278.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230914-topic-sm8x50-upstream-nb7-defconfig-v1-1-4f6fd9f3fded@linaro.org>
References: <20230914-topic-sm8x50-upstream-nb7-defconfig-v1-1-4f6fd9f3fded@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 14 Sep 2023 15:24:21 +0200, Neil Armstrong wrote:
> Enable the NB7VPQ904M SuperSpeed redriver/retimer as module as
> it is now used on the SM8550 QRD platform.
> 
> 

Applied, thanks!

[1/1] arm64: defconfig: enable NB7VPQ904M driver as module
      commit: 89bf1107b7762631262e94fc7f73fa81d4ec0b6d

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

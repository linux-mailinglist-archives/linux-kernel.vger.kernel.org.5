Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 828CC79F1D4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 21:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbjIMTSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 15:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232207AbjIMTSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 15:18:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E821BCA;
        Wed, 13 Sep 2023 12:17:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D40DBC433C7;
        Wed, 13 Sep 2023 19:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694632679;
        bh=YToAVNBw2DIfFt1Oan+3W5bAlg/qiUGu6fbt4xZmi88=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kwHJY478emMOre5uOWR961/0ASq0SFj8ofITT170PxJl5h5fyCf0Bkq1dYISsfHLj
         tZj3fTgvEID6BmZGxZHVqSmO051t/csm2ChwhMmlHE3Yo8ZKX/ZttA/w9+hmMseYFu
         Vi4YHfT4rApZuTpdXjjthxDx26VnBb1b4FNUo7991tt84TIc3W+qoHcrpkSsFEiAcM
         xFzwfe+pFbORsq5TTGwi5se27Q4hVgXqF2hpavHj6Bulzftgi87TuBCpu3z8eX/fLO
         Zj+dKXnk9A4X5jEU2anGiOqeKBJ3goGaStlT+qMLMm2vJs0kKyAOf1Imp/al3DXjBM
         1fp49TtxbC4/w==
Date:   Wed, 13 Sep 2023 12:22:03 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Alex Elder <elder@linaro.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        kernel@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 01/11] firmware: qcom-scm: drop unneeded 'extern'
 specifiers
Message-ID: <uqcxyz7wd5s2mm5hlkm3i62e4za5lkc3pj63zd4yfsgm23o5ma@5sabtewisqj4>
References: <20230828192507.117334-1-bartosz.golaszewski@linaro.org>
 <20230828192507.117334-2-bartosz.golaszewski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828192507.117334-2-bartosz.golaszewski@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 09:24:57PM +0200, Bartosz Golaszewski wrote:
> The 'extern' specifier in front of a function declaration has no effect.
> Remove all of them from the qcom-scm header.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

I wanted to pick the first two patches of the series, but they
unfortunately doesn't apply. Feel free to resubmit them on their own.

Regards,
Bjorn

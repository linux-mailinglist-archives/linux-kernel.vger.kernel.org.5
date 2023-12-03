Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 853418020DB
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 05:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233222AbjLCEwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 23:52:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233156AbjLCEwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 23:52:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB0613A
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 20:51:52 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0673EC433CA;
        Sun,  3 Dec 2023 04:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701579111;
        bh=yKZzimRPOiELfhstYOIdCWyYa+W/ni1uppnmF40LDYk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fXNxNk51PfFqJ0m+MMvYoXpCHzBWipjYYBWygIYQPjhHoMGrEsArWB20/Af5tEO0W
         nkKhSJE/jx95epORf1zEpMs5WK+Nv2Jq2L9zG85MbDKBppLR41DR1MnEkA6cA3ijC6
         HrEx+Z7KWA1C1yWc/tc9Ms9IRnYicjgyDsrixa2YPfgG6Ac9vk54gyQA8PaxhTEey2
         11IaR+svNJMrTUTcjEYnFq9eKZtvBGcorMf85lyDTmY3LmtcS40lY4+no69HPGj9Bt
         WqlgtkI093f8Vz9mf+1S1MlJyIJbqAmZ4i3JlQf5+lPKJ06EbLjNYwgRyW4n2/8Zz1
         PKuKqLm6R2lRg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Luca Weiss <luca@z3ntu.xyz>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sdm632-fairphone-fp3: Enable LPASS
Date:   Sat,  2 Dec 2023 20:54:40 -0800
Message-ID: <170157925832.1717511.16869847799170927483.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231015-fp3-lpass-v1-1-4d46a399a035@z3ntu.xyz>
References: <20231015-fp3-lpass-v1-1-4d46a399a035@z3ntu.xyz>
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


On Sun, 15 Oct 2023 22:06:56 +0200, Luca Weiss wrote:
> Enable the LPASS/ADSP found on the phone.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sdm632-fairphone-fp3: Enable LPASS
      commit: 2dee68e77cb5322d7cfe44f3c84ff8ae2eaf4aee

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

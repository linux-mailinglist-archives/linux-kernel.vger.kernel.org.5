Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFA0809999
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 03:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573014AbjLHCx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 21:53:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235659AbjLHCxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 21:53:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74051737
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 18:53:21 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71012C433D9;
        Fri,  8 Dec 2023 02:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702004001;
        bh=C4X0usRvU4SfNeCQDVnHklxdxVogajuqYsj5EA8PLTg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EhsuP/qLqzU09UVyqPJv6qVzvYH6KqJzocZId2ZFWF/ZfGN8r3I2qedC+fXF8+CRC
         2NHrZLWFoCxYSlZNB4KRG5dxW562DeoifTB5h6OMf4oGoaydyBLuwjCoCKeYriejjv
         dmquoSqUJQwnuRtcflYf/l6Oujnxa3yMml7IzeMMHgfPn2FtnbXTR/+ttB+z/qGt3N
         ijHzqBcNYho8zX0nfWEfo2mllD6PYoWeBwNgpN35xqI3VcFckoF7m3aO+66cSQQ4Pm
         QQE9cwqQDNws+D5bpYvf0bOG6krddzh90DlLXJxShLTFuJyLILb7mXpe0+ETIq77xA
         RfFMHO9RKpaCQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        dmitry.baryshkov@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jonathan@marek.ca, quic_tdas@quicinc.com,
        vladimir.zapolskiy@linaro.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [RESEND PATCH v4 0/4] Add sc8280xp CAMCC bindings and driver
Date:   Thu,  7 Dec 2023 18:57:26 -0800
Message-ID: <170200426913.2871025.848912452747333557.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231026105345.3376-1-bryan.odonoghue@linaro.org>
References: <20231026105345.3376-1-bryan.odonoghue@linaro.org>
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


On Thu, 26 Oct 2023 11:53:41 +0100, Bryan O'Donoghue wrote:
> v4-resend:
> - Remove erroneous "--in-reply-to" from git send-email
> 
> v4:
> - Resend of v3.2 addendum as v4 for tooling purposes
> 
> Link: https://lore.kernel.org/linux-arm-msm/20231024093919.226050-1-bryan.odonoghue@linaro.org/
> Link: https://git.codelinaro.org/bryan.odonoghue/kernel/-/tree/qcom-linux-clk-for-6.7-camcc-sc8280xp-v4
> 
> [...]

Applied, thanks!

[4/4] arm64: dts: qcom: sc8280xp: Add in CAMCC for sc8280xp
      commit: 9bd07f2c558f9c7d41f3761df3e93bd9ebaa0d4f

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

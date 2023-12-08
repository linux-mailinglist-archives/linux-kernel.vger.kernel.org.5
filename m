Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBA0180A618
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 15:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574166AbjLHOvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 09:51:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574087AbjLHOvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 09:51:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA24B19BC
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 06:51:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDF2AC43395;
        Fri,  8 Dec 2023 14:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702047077;
        bh=Mgz/X19oVnISptS/AZDYfWimbseZ3sluutSJ5YKISHo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RJR1fAyzkEYD89BQJdajdqxZmhlGLUNRHak6tAzY0+43WhTvRV0/Xrgs/Yt43CVv0
         +TykY27dVuZfcZesAaxDxxm4bMQIjY17uriyVRKfiN5NVDeEORR5NYQjmpFSQAh/NZ
         nw94L7qSgQvFLPn4/miLWl1FVhg9E1lHKE8iGojPDimS/LYG0wmndUYHt3W5wA+aFg
         K59xJEj7Pk+DZdNUSs7omLHj8jxO72YyuEbmhDcTwszm3h+QP9as9cZfgYVB01nOui
         HcdHG00IoWBXJWqIOoie+TLAjeMsChoZfBRT1Kyo/3XW6/pKE5k9Y1SnIG9QDUGiNV
         TWwcQZsQKFbHA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 0/2] qcom: socinfo: Add SM8650 SoC ID table entry
Date:   Fri,  8 Dec 2023 06:55:26 -0800
Message-ID: <170204733615.342318.2308942256537449998.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231030-topic-sm8650-upstream-socinfo-v2-0-4751e7391dc9@linaro.org>
References: <20231030-topic-sm8650-upstream-socinfo-v2-0-4751e7391dc9@linaro.org>
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


On Mon, 30 Oct 2023 10:55:18 +0100, Neil Armstrong wrote:
> For convenience, a regularly refreshed linux-next based git tree containing
> all the SM8650 related work is available at:
> https://git.codelinaro.org/neil.armstrong/linux/-/tree/topic/sm8650/upstream/integ
> 
> 

Applied, thanks!

[1/2] dt-bindings: arm: qcom,ids: Add SoC ID for SM8650
      commit: 216382b1555de2fe11684ffd99d598ac77a92ed8
[2/2] soc: qcom: socinfo: Add SM8650 SoC ID table entry
      commit: f61319e57d89e6e3d1ad16cb916074fdb7289806

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

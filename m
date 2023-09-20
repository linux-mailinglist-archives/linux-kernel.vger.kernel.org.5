Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669207A770E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 11:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233921AbjITJTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 05:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbjITJTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 05:19:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D7E83;
        Wed, 20 Sep 2023 02:19:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8352C433C8;
        Wed, 20 Sep 2023 09:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695201553;
        bh=9xBbxr+swRhwwQgmUTAanBRHI1SK4zTTAg4FJYXKK24=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Gwkcc8Xu5Nso+9thrscxOksnORUUzS6emX7ckBzzFxMBJUbeQsViBBg7tKz0IYHBe
         3xSxW2DGNqUJQpjF34PagKy3hH3cKXS78UuR5ptd4VCnObq9SqHDuIxPy+Rdng4Y8U
         Lsa1zPhYc55ZxPPTPJvLhF2jeJpl1avLsLfAKmcWhXsFzkWH0jL36nGGUl1sEEY/+4
         /mAqv7azDV4eECtV/HS7JZ3Vojf9HTNzYKJ6Wsze4zOdZsNnJp8tTK3pFSL0fRR7bm
         3tz3QRf/bFwz7LAEhAKqddoHPGQ8rnZNUgR8j6Sxe2+xa21kBRLRk4ffV1QcMgJ6vO
         3GIDT/6cj8Mfw==
From:   Lee Jones <lee@kernel.org>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        sboyd@kernel.org, luca.weiss@fairphone.com,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230816115151.501736-2-bryan.odonoghue@linaro.org>
References: <20230816115151.501736-1-bryan.odonoghue@linaro.org>
 <20230816115151.501736-2-bryan.odonoghue@linaro.org>
Subject: Re: (subset) [PATCH v9 1/7] dt-bindings: mfd: qcom,spmi-pmic: Add
 typec to SPMI device types
Message-Id: <169520155063.3348589.10688565387981596667.b4-ty@kernel.org>
Date:   Wed, 20 Sep 2023 10:19:10 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Aug 2023 12:51:45 +0100, Bryan O'Donoghue wrote:
> Add the PMIC Type-C port driver to the list of devices.
> 
> 

Applied, thanks!

[1/7] dt-bindings: mfd: qcom,spmi-pmic: Add typec to SPMI device types
      commit: 852355e98e45ec7f9adf06de92bba063424aa7cb

--
Lee Jones [李琼斯]


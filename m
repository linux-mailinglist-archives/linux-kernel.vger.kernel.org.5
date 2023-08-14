Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7166277B01E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 05:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232890AbjHNDZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 23:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbjHNDZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 23:25:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF545E62;
        Sun, 13 Aug 2023 20:25:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8DF0B628D1;
        Mon, 14 Aug 2023 03:25:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D990C433C8;
        Mon, 14 Aug 2023 03:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691983504;
        bh=JR2Q0v3eEua8jUSNr+H23tawxb0zi4HKIvK8yjgN8Q4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ra03CKYbEvXaru4c4AzzhNXLvIhnk+UK630+CUAIKVlvD6NdGI7OH159pSlBABIxk
         wbeYvpXpq7c7dSljJuKjB1osKAIqEhuuTbqD+ecdKwOu4pNP0HWPOQ/cYhBX4+lpsP
         F108kYrp+lGxRqIlgiATrPAdvJequUmsBx56uej290KMsLSKZyuCMEoy+rqurHF09N
         92CD9rnbYfNWfzCCHDIsepA3owuNYYmWccrgqwsUuyf50RGlUdF4t5mSSe35knjkry
         WmuQOAVR9lnuaxU7PV7WMG21DbiIlMpVaRnZW+hcNBDwqwjU3e2oN2ccxXnCeFXmUy
         cpNV3Ts/xPOzg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sm8450: Add RPMh stats
Date:   Sun, 13 Aug 2023 20:27:34 -0700
Message-ID: <169198364307.2443702.8632168838732419129.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230811-topic-8450_stats-v1-1-f26ae3fdf2cf@linaro.org>
References: <20230811-topic-8450_stats-v1-1-f26ae3fdf2cf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 11 Aug 2023 19:35:27 +0200, Konrad Dybcio wrote:
> SM8450 also exposes RPMh stats, hook them up for low power state
> monitoring.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sm8450: Add RPMh stats
      commit: 6578747ae2d76ce739ba81ffffb18b2222a87efb

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

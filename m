Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2C47B1001
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 02:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjI1AaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 20:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjI1AaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 20:30:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97839F5;
        Wed, 27 Sep 2023 17:30:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EA20C433C7;
        Thu, 28 Sep 2023 00:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695861001;
        bh=kXFSCeRU2ImTAfuVFvWc2Qp0CvqqeJOrJwWl5+HdpAk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=atPeUuvoPLi3iU+dg7MQuE4O7PqPJfd6TEPAINWhLnshhqP9xQOmzXnX+LLWu6yBJ
         hYJuR7q3aRBFudSxvb8F7ZFx2xY53PzDVZoQei3TqxGycOeVMHoshEPvAYAXL3JxeI
         xZ/hLAor3pDublhIXvj1xjtlsgCwpINT6pYGL2PF+NXM94mmgoeuwbfRZoRADjCqst
         Qp/JXiEDuPi1YzZo331Z7rP8x6hyUtYnGnibm4Sz8+xCu2GDV2pwtyIOVbRXouu+ZV
         Trymnp67pw1LcKjUt8VyqTEmf5b1TYcW6dQ3e/95KH4rIz49BAryNXT2dWXhhzdAYV
         QyxTvI+7USs7g==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [RESEND PATCH 1/2] ARM: dts: qcom: apq8064: drop label property from DSI
Date:   Wed, 27 Sep 2023 17:34:05 -0700
Message-ID: <169586125037.1226038.2973634569568481893.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230924183335.49961-1-krzysztof.kozlowski@linaro.org>
References: <20230924183335.49961-1-krzysztof.kozlowski@linaro.org>
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


On Sun, 24 Sep 2023 20:33:34 +0200, Krzysztof Kozlowski wrote:
> DSI node does not accept nor use "label" property:
> 
>   qcom-apq8064-asus-nexus7-flo.dtb: dsi@4700000: Unevaluated properties are not allowed ('label' was unexpected)
> 
> 

Applied, thanks!

[1/2] ARM: dts: qcom: apq8064: drop label property from DSI
      commit: 83daed13a5aa0ca563bfde920178ca67fbbdb5f3
[2/2] ARM: dts: qcom: sdx65: fix SDHCI clocks order
      commit: 88fc274cb6c4bd643b0157db2602f685af57b846

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

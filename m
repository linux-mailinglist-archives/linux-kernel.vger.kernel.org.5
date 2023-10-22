Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2892D7D23AD
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 17:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbjJVPqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 11:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbjJVPqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 11:46:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A4FA7;
        Sun, 22 Oct 2023 08:46:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DED23C433C7;
        Sun, 22 Oct 2023 15:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697989566;
        bh=286IEr6Au2fjEg8EUTjPOBmNUpcywoLU8+MN1g61aBw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UEDDOjk8xf2FP5mSSbJHg1CbKwjRtRe+R+MVb4G5Zvs7mxtvJjDe98jIJZwDwyOYj
         Pj0hXih9Fd6hnKmoJjQu+bTuOvZQkPqS32qxg1EETMkexyqM3YtAq0H7yrOH522Zg0
         LJa/WNSB302anTADe5FpE2214g4iNCyUYQQur2mepRyAhrvTXccN5Z+Ukg56NfBrcz
         PSWBGpN9qDwqf6e4JqLnL2b5pckOp7sxZ9RjP5bsaMsWGmQnGVLeEasdvEtX/slfoN
         guMiZIJA8arhpeEJb0tGHHJa62CEdBEU2Vl063zmgEERwBtzg9VkE64DbvHWusQw2r
         iYdqofxEKtLEA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp-x13s: add missing camera LED pin config
Date:   Sun, 22 Oct 2023 08:50:14 -0700
Message-ID: <169798982330.271027.9186412119973993390.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231003093647.3840-1-johan+linaro@kernel.org>
References: <20231003093647.3840-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 03 Oct 2023 11:36:47 +0200, Johan Hovold wrote:
> Add the missing pin configuration for the recently added camera
> indicator LED.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sc8280xp-x13s: add missing camera LED pin config
      commit: a3457cc5bc30ad053c90ae9f14e9b7723d204a98

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

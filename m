Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDF27D2475
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 18:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbjJVPqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 11:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbjJVPqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 11:46:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0CDF4;
        Sun, 22 Oct 2023 08:46:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5007C433D9;
        Sun, 22 Oct 2023 15:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697989567;
        bh=DrNGws2BbDIJSL5/4j3CgtnQlWq5CA2V5NGPeMNac00=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PqrBIifUu6XWT1lpS5o+VILXZKP5gkGS6XZyYbvlfJvm3U8E7MUk/9Z/tmUUtHNGq
         JwHC/QEGmoVz4CBGHx9Gwld6FQT2XkHwoRqwg0aY9iFzL6rL+WT/lW+Yffue4olBPY
         VMNlnqvn6DailPOuhlsJ2fhRoqdms17AZOCJNr2TL/mk62LsvVdsw1YuojMuHDvHIT
         Q/baKWbyUOfjV6Dy9GxoDB1MWGnsEFa+YjBH73Veoi82PijKfmAD1F7DLB2g1C4r2t
         OoLa/Bi8mai5oOa2Cmv2eAMYV1CFz/aecUuFyxS1QLusf0/1pcJ5KRmIqxV3MuLR6M
         44PhJPYcK+Zxw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp-x13s: Use the correct DP PHY compatible
Date:   Sun, 22 Oct 2023 08:50:15 -0700
Message-ID: <169798982297.271027.18200659862754581550.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230929-topic-x13s_edpphy-v1-1-ce59f9eb4226@linaro.org>
References: <20230929-topic-x13s_edpphy-v1-1-ce59f9eb4226@linaro.org>
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


On Fri, 29 Sep 2023 18:02:57 +0200, Konrad Dybcio wrote:
> The DP PHY needs different settings when an eDP display is used.
> Make sure these apply on the X13s.
> 
> FWIW
> I could not notice any user-facing change stemming from this commit.
> 
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: sc8280xp-x13s: Use the correct DP PHY compatible
      commit: 0cd080dd6d08817c9980d2069197b066636b0f23

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

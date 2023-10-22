Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DED547D23B8
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 17:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbjJVPqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 11:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbjJVPqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 11:46:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EFC6F3;
        Sun, 22 Oct 2023 08:46:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18BE3C43391;
        Sun, 22 Oct 2023 15:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697989570;
        bh=KqtvWHvEr2+HSDf51eJD5dXAJxO3x4VmurwGhZc1wtM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hLCbgrtqhmY1jO0WfLI1Va39wYLTFz8wABttbmsrMRURn3PV4LcwcyzdQCYg7IVL8
         CsYM9lUqZv8nOczoBJnbY9G6n74vl/JoKP/fy7CIaKOb6oSsZpv9en0PT9vvxx7lKT
         plsfBDwoSqbuUIgJWuN6vDH0G4kYKvpcn77JUte4OktSTTOFX412MUM1IIpU5BvMBA
         rJ6/zOQT2Q7qSVvxxPgoM5FWcbgrEAurKKrmvISrTpsJpEf9kx+NEV6hgG681t6le2
         oHxeIOz8kmLlrAoiY/UsRl9t7Ro5HjslnVGq51TzKtk6YPy1CyEtJSFGtuAJAF/kKT
         OVWumfiGhI4mA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Luca Weiss <luca.weiss@fairphone.com>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v2 0/2] Small updates / fixups for PMIC spmi-gpio
Date:   Sun, 22 Oct 2023 08:50:17 -0700
Message-ID: <169798982330.271027.14782440269787832990.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231002-pm7250b-gpio-fixup-v2-0-debb8b599989@fairphone.com>
References: <20231002-pm7250b-gpio-fixup-v2-0-debb8b599989@fairphone.com>
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


On Mon, 02 Oct 2023 09:00:10 +0200, Luca Weiss wrote:
> Update the schema to use plural _gpios label in the example. And fix a
> dtbs_check warning in pm7250b.dtsi.
> 
> 

Applied, thanks!

[2/2] arm64: dts: qcom: pm7250b: Use correct node name for gpios
      commit: 6cd8621758004d98f7c622c2d756c116c6888127

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

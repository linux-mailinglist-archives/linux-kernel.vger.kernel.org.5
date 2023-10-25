Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0713E7D7122
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 17:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343986AbjJYPot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 11:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232469AbjJYPor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 11:44:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66B1131;
        Wed, 25 Oct 2023 08:44:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 919ACC433C8;
        Wed, 25 Oct 2023 15:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698248685;
        bh=yk1+TBIWql/6xKTzf7Al0olsihyW9HN32xrt3HZ5UBI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=QAK84zCh5klcpa+EAiiCX1PmLrhd6uR/Y+VXlxabYBcvdmmvUM59hbBTgddCaCgqU
         P7lzF67lTdHZ30BVLgikVO9CTpCCVr76C6Ikf7boAmpCnkThlOH1cTJ3bQY7qzgphp
         h1AsylwTMUGeEHkWsFLSddu47kL2aflXoOC2sNKElZektHOeqclHcmls7HzoMHW+Ym
         4OSkkJx3usctm1rxR/Y9mKIXdFHVB7ZzGTW4UpEbkrA5wa5P8xNzz5mn9GF8fFvnaf
         O0aMhWuFXQtbMs875fY7U4gDBfp/du6E3OVwcePqeS9LuVruVBnFCSNyA8NfeDBfXQ
         QOaebiuZsWTVA==
From:   Lee Jones <lee@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Nikita Travkin <nikita@trvn.ru>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
In-Reply-To: <20231023-pm8916-dtsi-bms-lbc-v2-1-343e3dbf423e@trvn.ru>
References: <20231023-pm8916-dtsi-bms-lbc-v2-0-343e3dbf423e@trvn.ru>
 <20231023-pm8916-dtsi-bms-lbc-v2-1-343e3dbf423e@trvn.ru>
Subject: Re: (subset) [PATCH v2 1/3] dt-bindings: mfd: qcom,spmi-pmic: Add
 pm8916 vm-bms and lbc
Message-Id: <169824868224.758275.3309948002942732059.b4-ty@kernel.org>
Date:   Wed, 25 Oct 2023 16:44:42 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Oct 2023 11:20:32 +0500, Nikita Travkin wrote:
> PM8916 (and probably some other similar pmics) have hardware blocks for
> battery monitoring and charging. Add patterns for respecive nodes so the
> devicetree for those blocks can be validated properly.
> 
> 

Applied, thanks!

[1/3] dt-bindings: mfd: qcom,spmi-pmic: Add pm8916 vm-bms and lbc
      commit: e9aec86e211ee493081e8934b8c821d660b417ee

--
Lee Jones [李琼斯]


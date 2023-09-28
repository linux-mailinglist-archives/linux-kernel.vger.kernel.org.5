Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 494297B100D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 02:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjI1AaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 20:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjI1AaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 20:30:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70849F5;
        Wed, 27 Sep 2023 17:30:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 375CEC433C8;
        Thu, 28 Sep 2023 00:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695861004;
        bh=V63eA5yCKI+xdf6WmB5lSNze6MwPjapovYb9697Emnc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TIPv+MA69gM390NSnBkE5SWeMMdkT2pXxflO0QoI2tuaenlVsx5yQJiJIOh5oMR0G
         MnJ8OA3uS+J1ILbCn8iLRAYh2XeSJNQ/qOje3nLTcoHMIiebdA+ubtgyQKtH5Y5jfE
         zayvqgKyS+e2Bcbzp2XSGzNmmT0Mx3aCnzQHTSvS7yYlaFITF3mf1PQxE7JakoDz9J
         gTu50u4ER3kYYQdvKfgS2pyN5FTEajTMIpUT/nMub3SRZEUkBkt8A3PCPnp8yRUdvV
         5y9FqGx0g79RM3pvx8WHUmsAZMGwlFDFTxQZje7EHxtdTNapq5CKuDH+eg5+PqKWgR
         x3cvOPLFmc5ew==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-arm-msm@vger.kernel.org,
        =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: qcom: apq8026-samsung-matisse-wifi: Fix inverted hall sensor
Date:   Wed, 27 Sep 2023 17:34:08 -0700
Message-ID: <169586125032.1226038.6907362990209916790.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230922011211.115234-1-matti.lehtimaki@gmail.com>
References: <20230922011211.115234-1-matti.lehtimaki@gmail.com>
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


On Fri, 22 Sep 2023 04:12:11 +0300, Matti Lehtimäki wrote:
> Fix hall sensor GPIO polarity and also allow disabling the sensor.
> Remove unneeded interrupt.
> 
> 

Applied, thanks!

[1/1] ARM: dts: qcom: apq8026-samsung-matisse-wifi: Fix inverted hall sensor
      commit: 0b73519790d29e4bc71afc4882a9aa9ea649bcf7

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6E347792C0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 17:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236370AbjHKPSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 11:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236214AbjHKPSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 11:18:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA5530D6;
        Fri, 11 Aug 2023 08:17:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ACD8467478;
        Fri, 11 Aug 2023 15:17:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65FB0C433C7;
        Fri, 11 Aug 2023 15:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691767072;
        bh=NywsLMkFIXXBjoRxvA3juBt0FEQfoxXG1eLIJaWm6Vo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OmFoQGiCIAtFEiqP+bMyP7RfQp3ZqcEH5gK53BU5jZwBADiBYfFv/SqbONzOu8Ju0
         SgZRXKxbl6Wi04HzyAvRx+K0rQwlRxV1vcDVU4z8RRHkR9SfRzFPrfY4F5rknDX2Ff
         bUpCBTIGMjYuc+/JnNwZZsb+0bEFmrt68Co9P2YyydqyumwsF2MIaMV6rFegbKQqOT
         ok75Y5b6ZpEVrlKPSY4Ob3ShJ2rTy8iZZuKOdWYdXf4uZcA5nXSII1LkMEU+JK9RMD
         WQvtpJu4/2eQsUp2y2uQUhtqlPgBwAt8EyYaveJG2ja0BGm9hvSX/h155iiWEtaCTc
         eyX35BUJtYBwQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 0/1] Enable CAMSS on non-mezzanine rb3
Date:   Fri, 11 Aug 2023 08:20:39 -0700
Message-ID: <169176724024.691796.5073153756690898669.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809203534.1100030-1-bryan.odonoghue@linaro.org>
References: <20230809203534.1100030-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 09 Aug 2023 21:35:33 +0100, Bryan O'Donoghue wrote:
> Similar to the apq8016 case we can run the Test Pattern Genrator (TPG) on
> the rb3 absent a mezzanine or connected sensor.
> 
> Link: https://git.codelinaro.org/bryan.odonoghue/kernel/-/tree/linux-next-23-08-07-db410c-rb3-camss-dts-v2
> 
> Bryan O'Donoghue (1):
>   arm64: dts: qcom: sdm845: Enable CAMSS on the bare rb3 board
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: sdm845: Enable CAMSS on the bare rb3 board
      commit: 5480b0c67f120a6c293cc5eff72fa1d6a74de504

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

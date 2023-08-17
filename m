Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB7C977F53A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 13:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350318AbjHQL2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 07:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350390AbjHQL21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 07:28:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C83235A0;
        Thu, 17 Aug 2023 04:27:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F1B7641FB;
        Thu, 17 Aug 2023 11:27:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D58B4C433C7;
        Thu, 17 Aug 2023 11:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692271667;
        bh=En/6rlHiA/49WSvMc2Cvth0wJmj9imCKyDrGG6MmbW4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=OX6mvAJmt0iAhd2qMK3VK0E9aLGHwSBhsrdlXmhtWL1pf97zPEgPYE8zZ4cDpW2sx
         gaJrpc7SRi1QuXo0D0SwsFPVOzEPFQAZSpFXs2gHYnb/CwX0JegvQX2ViC9W7SX8QO
         kxPPKKgcBE5LXQ4exkx1wQIe8o9CcVUHn5+xGF7jA0LGWwls8Zq3hslh7J36blRkbF
         j1/W8Sb9yu24ggPv2Df7K/G/NEqPsHo/Tdn7Yv8OK20HbExqGvIEh+NgKr3138tpHE
         zo3HpTCN5YvL/NFwEsNpOCyxtiUdNg15zHpfaBmvwSwjoGd9apykb1hTs3HHaFOPtJ
         3nyu/su7AQIww==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org, Fabio Estevam <festevam@gmail.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, mazziesaccount@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Fabio Estevam <festevam@denx.de>
In-Reply-To: <20230804021657.190700-1-festevam@gmail.com>
References: <20230804021657.190700-1-festevam@gmail.com>
Subject: Re: (subset) [PATCH] dt-bindings: mfd: bd71847-pmic: Remove
 unneeded LED header
Message-Id: <169227166435.995996.12239928328504296743.b4-ty@kernel.org>
Date:   Thu, 17 Aug 2023 12:27:44 +0100
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

On Thu, 03 Aug 2023 23:16:57 -0300, Fabio Estevam wrote:
> There is nothing from <dt-bindings/leds/common.h> that is needed by
> the binding example.
> 
> Remove the unneeded inclusion.
> 
> 

Applied, thanks!

[1/1] dt-bindings: mfd: bd71847-pmic: Remove unneeded LED header
      commit: af18b213632b2cc002773a81f2dec75b8b266048

--
Lee Jones [李琼斯]


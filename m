Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D097A83C8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 15:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235132AbjITNrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 09:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234698AbjITNrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 09:47:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36EEAC;
        Wed, 20 Sep 2023 06:46:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD4EEC433C8;
        Wed, 20 Sep 2023 13:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695217619;
        bh=dBGRbuxNukRXbCtz9In2yhS+++hVLMIGSxm4jlSnasQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=iEXiZ1gLIj8peOlIiFkmdudyE9LimPVizJ8NyJju2ik/EzRelagdoufjErmi3qyeC
         AIZlYEAaC7g3e/qfkbsJKIIDvNJL8Rki9gUbaWYW+CSniJB5xAtyKshieDbA5wp7KB
         /kDTeCHq6CJYGhNvb+Z5UaXnuQIZ7IYo6jKq7O8WqmZ6Y5rH5FGpa2Nhx9MzcA+eEA
         N/210o4x99na7cQ1hrD4RuoJA2nEuIozlwZBgD5zW/HgOySgGshctgmGDOqngyToKB
         OhA2PYcBJHWlo47p9UBPo4lNfSnR5DmK1jMfzkTjW/ltAKYPHlD6QEGWYHNbnPnArJ
         pXiVr+to2h15A==
From:   Lee Jones <lee@kernel.org>
To:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Keguang Zhang <keguang.zhang@gmail.com>
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230914114435.481900-2-keguang.zhang@gmail.com>
References: <20230914114435.481900-1-keguang.zhang@gmail.com>
 <20230914114435.481900-2-keguang.zhang@gmail.com>
Subject: Re: (subset) [PATCH v5 1/3] dt-bindings: mfd: syscon: Add
 compatibles for Loongson-1 syscon
Message-Id: <169521761559.3446293.1897507502065442678.b4-ty@kernel.org>
Date:   Wed, 20 Sep 2023 14:46:55 +0100
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

On Thu, 14 Sep 2023 19:44:33 +0800, Keguang Zhang wrote:
> Add Loongson LS1B and LS1C compatibles for system controller.
> 
> 

Applied, thanks!

[1/3] dt-bindings: mfd: syscon: Add compatibles for Loongson-1 syscon
      commit: d6e3854f720f13bad60c086d3cb4ea2c1958214a

--
Lee Jones [李琼斯]


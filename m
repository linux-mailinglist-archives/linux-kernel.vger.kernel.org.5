Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C564C77F2BE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 11:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349294AbjHQJHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 05:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349378AbjHQJG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 05:06:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB602D40;
        Thu, 17 Aug 2023 02:06:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D1C4865B66;
        Thu, 17 Aug 2023 09:06:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C38AC433C7;
        Thu, 17 Aug 2023 09:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692263208;
        bh=SqQbXc1eQwPHkS8qcXpAjk0yPygmpKpDzq9KX0jTsw8=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=WUj/PAgbUwqPOCkCUdR8yrwdEQnNDls8Wnt48XbsPnOFk5QN7LF0QqE9IzX1n1GLo
         uUHnAs3QtQe5M27/xRrWgakO3RPCLhyYmTO7CxFWVEqZwqbJNx+c13+WhGeSWZbys8
         2k6GCG15YCXEtIqu3O9ybY2w2JAhkrPXIMW8z4dpqjtGuPkodmPZYuiOdzRVAmKnuB
         t5TqTCFiLAbzCgdRmCk4T7fNqN9LfXZJL/z21+AvdjGiAieIyNczTWB0tlXkSr6g86
         0w6mdxUwP1IOy4PqwtDeeYVIdcATSHsTrk3bUEv/hl/jGy7E2itNghei4Gdbvhf5Cv
         ASeagLPufNSZQ==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Varshini Rajendran <varshini.rajendran@microchip.com>
In-Reply-To: <20230728102550.266134-1-varshini.rajendran@microchip.com>
References: <20230728102550.266134-1-varshini.rajendran@microchip.com>
Subject: Re: (subset) [PATCH v3 17/50] dt-bindings: atmel-smc: add
 microchip,sam9x7-smc
Message-Id: <169226320596.930413.6357154496969671577.b4-ty@kernel.org>
Date:   Thu, 17 Aug 2023 10:06:45 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jul 2023 15:55:50 +0530, Varshini Rajendran wrote:
> Add microchip,sam9x7-smc to DT bindings documentation.
> 
> 

Applied, thanks!

[17/50] dt-bindings: atmel-smc: add microchip,sam9x7-smc
        commit: ca3fd125e95c91a779342293373aa509d1eef028

--
Lee Jones [李琼斯]


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 784B47788FA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 10:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234459AbjHKIak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 04:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbjHKIaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 04:30:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11AD630C0;
        Fri, 11 Aug 2023 01:30:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A565D64CD0;
        Fri, 11 Aug 2023 08:30:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF4D8C433CB;
        Fri, 11 Aug 2023 08:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691742637;
        bh=9IG8uNLc0T7yeYC5H+HbxR8/JxuZHHX9NigCQAULIPk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=KFx/EwtSreaqN1gTlo099WB/vQAbPLwNgq2GnUFG3YK74qfEXTpCjekwyTL7hESVA
         XyfVMoJHPeaWqOHKMUwTyscTTxLfTFMaKof7cpHIcrRaNdv1ZU8W6O99Cn+1fKhl59
         jAtFJ+N2U96xNgvuXxDj4pmzm7A17/luS1w6PwXHG7iaxvNQ+HNCrUrjDDJ+fDthjQ
         piFUyC8B7Kp6wiZEdmjn5aIK5Y4S7nthOHMRZp8sGXlzeFRFBbhXL+xbc6xT8j83Qc
         y6uT59a2X3mdxcM4DY6gR/ANY26I/jHZMLfVY7DbYUzHLLk0+jn1fkp1ZKzC5M9XMl
         pwi2NEogDqcgA==
From:   Vinod Koul <vkoul@kernel.org>
To:     Jack Zhu <jack.zhu@starfivetech.com>,
        Changhuang Liang <changhuang.liang@starfivetech.com>,
        Minda Chen <minda.chen@starfivetech.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-phy@lists.infradead.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230731114856.14401-1-lukas.bulwahn@gmail.com>
References: <20230731114856.14401-1-lukas.bulwahn@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: correct file entry in STARFIVE JH7110
 DPHY RX DRIVER
Message-Id: <169174263563.106197.3926692362175021526.b4-ty@kernel.org>
Date:   Fri, 11 Aug 2023 09:30:35 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 31 Jul 2023 13:48:56 +0200, Lukas Bulwahn wrote:
> Commit f8aa660841bc ("phy: starfive: Add mipi dphy rx support") adds the
> MAINTAINERS section STARFIVE JH7110 DPHY RX DRIVER referring to
> 'phy-starfive-dphy-rx.c', but the file actually added in this commit is
> named 'phy-jh7110-dphy-rx.c'.
> 
> Correct the file entry in STARFIVE JH7110 DPHY RX DRIVER.
> 
> [...]

Applied, thanks!

[1/1] MAINTAINERS: correct file entry in STARFIVE JH7110 DPHY RX DRIVER
      commit: 6ac1bb86953cc8a2419a4845de56c280b6f62890

Best regards,
-- 
~Vinod



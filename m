Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61154763ECA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 20:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbjGZSpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 14:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbjGZSpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 14:45:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239452125;
        Wed, 26 Jul 2023 11:45:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8ECE461C17;
        Wed, 26 Jul 2023 18:45:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB1C0C433C8;
        Wed, 26 Jul 2023 18:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690397141;
        bh=wjbAncjzdChPNXsbcDICv+H0kkp161w6++NSgxLMdxQ=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=SjvyVGQPAjQmGTgnpkeeOstVxYM9sOdgxQh6cxqTbenjQDpsDk5cumDO1mEk/ZJxn
         s2w3XUJMSVTIeDH9OC7nfvfz+uU2YSUv7CBBoL244lLyg1KuEAXQI2HEezQ9oQD8uM
         qVmvtc6O9lxhwT9O7rq/LsD38XkHcVCgaBAFL/5nPjY2Xun/jXVxPrsU/8FwRQpA56
         2jJcXjaGanMEzHZhDfoPvNodbSnvQLQhHSM9k1D5KMKnwHzYxNHaeJzJXPZv5h86VT
         PgV0P58qkJgvUHCKUCwl/b2xQlccYwe4pqSF6wkKrtoR6cCWU2ypZ+/3i3LnRYgNfS
         uUddz/1ddVFUQ==
Message-ID: <a5244f4c5a91c4c8e746b40f92359789.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230724055440.100947-1-xingyu.wu@starfivetech.com>
References: <20230724055440.100947-1-xingyu.wu@starfivetech.com>
Subject: Re: [PATCH v1] reset: starfive: jh7110: Add StarFive STG/ISP/VOUT resets support
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Hal Feng <hal.feng@starfivetech.com>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
To:     Conor Dooley <conor@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        linux-riscv@lists.infradead.org
Date:   Wed, 26 Jul 2023 11:45:37 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Xingyu Wu (2023-07-23 22:54:40)
> Add new struct members and auxiliary_device_id of resets to support
> System-Top-Group, Image-Signal-Process and Video-Output on the StarFive
> JH7110 SoC.
>=20
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> ---

Applied to clk-next

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E547D45FA
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 05:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbjJXDah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 23:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232176AbjJXDa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 23:30:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FEF9D68;
        Mon, 23 Oct 2023 20:30:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 045A7C433C7;
        Tue, 24 Oct 2023 03:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698118226;
        bh=sNdRqHfvYq7veOCjqXHETnlhkGTBUDiKkQb4mBoQZXQ=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=sYo+fWiELMkZXCMC1scpeZnUjKqB6MwNsz5XoFUZPyOMpTSltnjjT/XULT7braUAo
         FGU11hdTvtF5v3cfZI+FlC8R5DV9vLry9HI2I0FYGDioCP+MYyq1sXFmt9ASEKKPDQ
         nGSI4VgA5Xsd8YU8/KsZrV//FTk8EtDaRcQbWAVXxQWQbJxzuYE8EXuKKJfadcbwJ3
         MGFWbwi1i8Fx09NNdn1MBsVkvTU+cobAG7Cauvyl+tSJmj19Hc1vCgr3k7R7ZL8dMm
         WKeZcUFs9Xu5cZV5fpZBm6SksckMkUPwevEDKoz6zlQDaHsYGRuIa7QX2DBjgkOwt5
         FI3GwpD6ZSQvQ==
Message-ID: <e1513c65969415749c7806d4ccbb7f8a.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230725004248.381868-2-samuel.holland@sifive.com>
References: <20230725004248.381868-1-samuel.holland@sifive.com> <20230725004248.381868-2-samuel.holland@sifive.com>
Subject: Re: [PATCH v2 2/2] clk: sifive: Allow building the driver as a module
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Samuel Holland <samuel.holland@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
To:     Michael Turquette <mturquette@baylibre.com>,
        Samuel Holland <samuel.holland@sifive.com>
Date:   Mon, 23 Oct 2023 20:30:22 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Samuel Holland (2023-07-24 17:42:48)
> This can reduce the kernel image size in multiplatform configurations.
>=20
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---

Applied to clk-next

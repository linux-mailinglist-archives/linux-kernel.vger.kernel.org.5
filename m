Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84A9C7C46C1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 02:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344353AbjJKAeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 20:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344418AbjJKAd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 20:33:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CAF199;
        Tue, 10 Oct 2023 17:33:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFFC7C433C7;
        Wed, 11 Oct 2023 00:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696984431;
        bh=ZUc+XmAezQGKxBk/Xe4iwYdTT6X1zdigOg+R4Hg2+3A=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=SDhtsqo5vWvKFqJ7mSEE/wFQh/KQZdXORYXsACO4k2ZAUhjRKM7XaTNZ3NgMeBYR1
         98XOyLMuCMDuiA3xa/Cgw0gC/x+WM+KgXLtm9k0ezbt8d008oUZUal+Vmb/A6Qp+Vi
         Ae3ipwct4UEkF65nZ38Fo3QajYfJX7+dTjE9l/pft1/ZQl+/qur7zl6wKVw0mnXsoM
         gCeod7Yda6uAPAAAYfkRIiPKZLCVsd5XOeOO/rdrU+XyIlAfM02/Ea6tPKZ40Ypg7j
         xwCLh49W1mL5Fhdeo6XABvRb61q1E6veTjJCLEYf3eQepgXiWkciuHIkF4Wx58LN+a
         7yPZS6wJdVrlQ==
Message-ID: <839e7504e48ab330d8d8da12b3fc36b0.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231004-scmi-clock-v3-v5-2-1b8a1435673e@nxp.com>
References: <20231004-scmi-clock-v3-v5-0-1b8a1435673e@nxp.com> <20231004-scmi-clock-v3-v5-2-1b8a1435673e@nxp.com>
Subject: Re: [PATCH v5 2/2] clk: scmi: add set/get_parent support
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Peng Fan <peng.fan@nxp.com>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
To:     Cristian Marussi <cristian.marussi@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Peng Fan (OSS) <peng.fan@oss.nxp.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Date:   Tue, 10 Oct 2023 17:33:49 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Peng Fan (OSS) (2023-10-03 16:42:24)
> From: Peng Fan <peng.fan@nxp.com>
>=20
> SCMI v3.2 adds set/get parent clock commands, so update the clk driver
> to support them.
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>

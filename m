Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3749D7D456E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 04:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbjJXCXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 22:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjJXCXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 22:23:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3EDB9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 19:23:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36C46C433C8;
        Tue, 24 Oct 2023 02:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698114194;
        bh=8ZaH0MDvvHfzDxjSMv1D/503RQvHmZjhF2jnF7B3KjI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=jVpLD8HvZfDx1+iX8aQCsGBSyb9G3Z/x2uNggeifEANFy7wqm1wy2ysk7+O/h9LiI
         LUScVsZRE3tgfL3rNxme1p3qPM3KbNEbb11UeRtAj9M033p/s5QbJFZ+cmTfzW/0zF
         bn/HcOk9DCywbvssVzUaDk0sZZKfDSZbNT7Tgnu4ygun2yF0prlnwFRlamsfTKOnLP
         3bDdCRqfoRANjDeiFu1dytmxbhd45/P1e0XeOU3rNIFqPmSwKI3sdQGL59+6i9XYlY
         Bgih7whKhMFLwyuYZcJ4scsKU8lLHfEucNqDcGTkYA81F2SsUoZeBMDAOdzbrFQNFx
         oUitgqTxHRdow==
Message-ID: <645abb26a40d4e03e5ec3558f9204083.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230518040729.8789-1-sen.chu@mediatek.com>
References: <20230518040729.8789-1-sen.chu@mediatek.com>
Subject: Re: [PATCH v2] spmi: mediatek: add device id check
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, Sen Chu <sen.chu@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sen Chu <sen.chu@mediatek.com>
Date:   Mon, 23 Oct 2023 19:23:12 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sen Chu (2023-05-17 21:07:29)
> Add device id check for spmi write API.
>=20
> Signed-off-by: Sen Chu <sen.chu@mediatek.com>
> ---

Applied to spmi-next

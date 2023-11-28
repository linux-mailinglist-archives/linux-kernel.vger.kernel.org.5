Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354A57FAFFC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 03:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbjK1CQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 21:16:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjK1CQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 21:16:26 -0500
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A47F91A3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 18:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1701137790; x=1701396990;
        bh=xMK98BjzCiilBY7AywmUE609Wi5vISxDEAU13hjmP2Y=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=ZW2nkU83nuwO5jyZeLkopZ331T0I971E4ps4A0vjniiZh9axYt1W3juaAzS+mkSpe
         xqxJQd4mi5lNfvMIDK1+z/h3LmYdbSmIN3p7Ryu7YdsCS3P9gfBUXlTVHqsv+MLOaN
         4c7qofXUTct+MP5YNpK3izOUGIowph60Ca9NQgogZqfdLv134YcrMTCF5WYXbcKwP3
         /eUe/SR870QgOTOvQ72dIXJW4c9Gmu3GOyG0dScgKJUU8BBshAutToiS0+ItAySzKz
         NqCNNcP4I0nhcPhXuKTQgQAJUxmYE+OwTkKKr7WljC13CTAGmn8EERA6WT5FDqa3B6
         r7dly0ypBnivw==
Date:   Tue, 28 Nov 2023 02:16:27 +0000
To:     Alexander Koskovich <AKoskovich@pm.me>
From:   Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc:     roderick.colenbrander@sony.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] hid-playstation: Fix button maps for the DualSense Edge controller
Message-ID: <87bkbeei6g.fsf@protonmail.com>
In-Reply-To: <20231126001544.747151-1-akoskovich@pm.me>
References: <20231126001544.747151-1-akoskovich@pm.me>
Feedback-ID: 26003777:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Nov, 2023 00:15:49 +0000 "Alexander Koskovich" <AKoskovich@pm.me=
> wrote:
> This brings functionality of the DualSense Edge controller inline
> with the stock PS5 controller.
>
> Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
> ---

Will provide a follow-up to the relevant discussion.

  https://lore.kernel.org/linux-input/P8jVfYBAwiM_8MIgshN0osVVfshfBH2-oZCQu=
qoqh0Hy76_031zuZvYXWl0edtfTUwDOSNlc5priSRXI3G5dboVh5VPbcdxzAcEF7EvUVgo=3D@p=
rotonmail.com/T/#t

Since I assume this patch was not actually tested to resolve the issue
based on the evtest results, I think we should drop this patch. Will
mention some details I might have with regards to the behavior you are
seeing with Steam/Proton specifically.

--
Thanks,

Rahul Rameshbabu


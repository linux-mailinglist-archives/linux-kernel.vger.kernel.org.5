Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC3F78422D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 15:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234693AbjHVNhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 09:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjHVNhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 09:37:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09687198;
        Tue, 22 Aug 2023 06:37:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 94DB663355;
        Tue, 22 Aug 2023 13:36:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8017FC433C7;
        Tue, 22 Aug 2023 13:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692711418;
        bh=Juy+WYXEpzRzMZj+RiAQX5RgXS5Jq3gwBNJKN+Jpkg4=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Af75jDTWCj86Ls20/lQMpvSU67mAOKh3mkQAk/P0/WAoKOEqMCnnfJn/zdJd6qYWq
         D34P0yWu9VzpnmkYtMk3VZK2TRFm4/pGZaTpt4ERTNF52B2hJNpcI+QXuQg4UxIOab
         NyvuUt0M4NegzSKdv8XiqgR11RYK6tzDzdTA4i78SADwQHE5axuaxfFKSu4Z+gqeZT
         9iiQfIyABv+uMg9jqY3xjo5HpTZHVaxJQOyExY3JHOWdplmPJ/Jt/ajXxT1faNj9Za
         MGOj6yOYxXWYvR6e1WVaJuEStGxNKATFc4H617GsA/vCxwLvpK8BLN5idJnvc9EMiO
         tT/Ylgz8SHduw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] net: wireless: ath9k: fix parameter check in
 ath9k_init_debug()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230712114740.13226-1-duminjie@vivo.com>
References: <20230712114740.13226-1-duminjie@vivo.com>
To:     Minjie Du <duminjie@vivo.com>
Cc:     =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        linux-wireless@vger.kernel.org (open list:QUALCOMM ATHEROS ATH9K
        WIRELESS DRIVER), linux-kernel@vger.kernel.org (open list),
        opensource.kernel@vivo.com, Minjie Du <duminjie@vivo.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169271141562.680890.6268929077513822394.kvalo@kernel.org>
Date:   Tue, 22 Aug 2023 13:36:57 +0000 (UTC)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Minjie Du <duminjie@vivo.com> wrote:

> Make IS_ERR() judge the debugfs_create_dir() function return
> in ath9k_init_debug()
> 
> Signed-off-by: Minjie Du <duminjie@vivo.com>
> Acked-by: Toke Høiland-Jørgensen <toke@toke.dk>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

6edb4ba6fb5b wifi: ath9k: fix parameter check in ath9k_init_debug()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230712114740.13226-1-duminjie@vivo.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


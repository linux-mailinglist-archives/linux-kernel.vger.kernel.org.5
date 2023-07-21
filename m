Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E8975C59B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 13:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjGULMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 07:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbjGULMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 07:12:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE36358B;
        Fri, 21 Jul 2023 04:11:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C34E61961;
        Fri, 21 Jul 2023 11:10:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32F86C433CA;
        Fri, 21 Jul 2023 11:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689937805;
        bh=doH7QBRGiTSMgWAl8lnHKFFkVmk48+gAH6oH3iUKSSk=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=TeAAwkPYEkdHeLK0jHxq6rhHVazN/1TU7+62HrOkZfmqnl2lsKp3jBdYSSSx3x6Uh
         m15wh0fBK+D8y/YNmxsYmZbhKqahbucNApMvstvBdluZ1jjMWp3xqUeOWKIgMVPmHn
         /VuGq9YznORGspLjh+kXxyfS4zeYzoKVtb1T9v+EMRd8I2SJaIjLsOOItDHDp9Cyov
         wYV0qE0CJlIdZ8XcBcTBG8nm4qUcKUew8YQR8u4OhZVhYtwIvL0eJ9oMTZrVXaEyEP
         IgzxkYYIZv+2ogIMyEQdmY0HIQJr2qb68R+SiKTahVIeZdt05ZiiBl8mp33tp2Ti/M
         bLI+aH7ty9Iag==
From:   Kalle Valo <kvalo@kernel.org>
To:     linux-wireless@vger.kernel.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev,
        Johannes Berg <johannes@sipsolutions.net>,
        Jakub Kicinski <kuba@kernel.org>
Subject: Re: Closing down the wireless trees for a summer break?
References: <87y1kncuh4.fsf@kernel.org>
Date:   Fri, 21 Jul 2023 14:10:02 +0300
In-Reply-To: <87y1kncuh4.fsf@kernel.org> (Kalle Valo's message of "Tue, 13 Jun
        2023 17:22:47 +0300")
Message-ID: <87sf9h1px1.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kalle Valo <kvalo@kernel.org> writes:

> Me and Johannes are planning to take a longer break from upstream this
> summer. To keep things simple my suggestion is that we would official
> close wireless and wireless-next trees from June 23rd to August 14th
> (approximately).
>
> During that time urgent fixes would need go directly to the net tree.
> Patches can keep flowing to the wireless list but the the net
> maintainers will follow the list and they'll just apply them to the
> net tree directly.

A change of plans, I'm actually back already now and have opened both
wireless and wireless-next trees. I will go back offline at some point
but hopefully Johannes will be back by then.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

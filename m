Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0B757C9308
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 08:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232859AbjJNGmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 02:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJNGmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 02:42:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E4B83;
        Fri, 13 Oct 2023 23:42:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7893DC433C8;
        Sat, 14 Oct 2023 06:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697265725;
        bh=Pvnp6ClDU4xAPFz+GWQJRLH4Q1XIrlzcHFNtXw92fUQ=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=IFrC+uuAlTszbKfHKFobiZGt35OWBZvGIonkyj/r68qF6fQ4z4aH3+ZHBwyT6DQKs
         ELO4kjrrSll4lLcK9w56nn+NB7JrCGdQvbIJANYfbesEssGtFyCZ+tdDXiRLEuPNJq
         NWwxEif8pM/z0It850p4If9P7PDrKK+caiQZm8Ke206qqfEU7zRXLr3O/dR9Rv3TjV
         4E2UvmNu6xmMx5QDGnwzGOQOVNAsLbl/6xTKRmXaPgBolYcIOLnZEWONO1c4eYjN+/
         1/nv6HMX+Fjtz2RfLiUGcLbZCxDtcsa6TkxLpQqA2KQc3slwOjmr8G4QkwkmDherTt
         49buWmwGgjxzw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 08/10] wifi: atmel: remove unused ioctl function
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231011140225.253106-8-arnd@kernel.org>
References: <20231011140225.253106-8-arnd@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-wpan@vger.kernel.org,
        Michael Hennerich <michael.hennerich@analog.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Rodolfo Zitellini <rwz@xhero.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169726572036.3637479.12619977038667266484.kvalo@kernel.org>
Date:   Sat, 14 Oct 2023 06:42:02 +0000 (UTC)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> This function has no callers, and for the past 20 years, the request_firmware
> interface has been in place instead of the custom firmware loader.
> 
> Acked-by: Kalle Valo <kvalo@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

2 patches applied to wireless-next.git, thanks.

166ab7ca3418 wifi: atmel: remove unused ioctl function
f35ccb65bd18 wifi: hostap: remove unused ioctl function

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231011140225.253106-8-arnd@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


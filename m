Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F06E7D4094
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 21:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbjJWT7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 15:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjJWT7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 15:59:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F11DEE;
        Mon, 23 Oct 2023 12:59:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09E35C433C7;
        Mon, 23 Oct 2023 19:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698091178;
        bh=4k58y7meSTe6yhK2m/jmZQ1cwFI4QLr1oNCOS01MlaM=;
        h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
        b=o+YUVrYxCuQ/AEvm+WQCiWxuEvKrqSrtkc2amwRqQUmdr5XRBV2dzeHfw/WbbZSh5
         UPcPd7mu/SqAqn88gT+mTwOAOowjsyCO5xt6oVm4/ekc+FVzrTe+TRtVSqj7dvQZF5
         dbfldde+2ShWBVONcFC1//wMIeq3zS//pwrlRjKs/KzggumPSVQUMa6j0ygE3sm5qV
         D3Y2RSMehdy7kTQRKiNkpRfnUqolzS11LN8gnf0n65MRBbMx9NX7ctVYM5a3ggghqK
         J0YLngJfg1U2UdhDxWocV3WHMhr0RCLZ0NFgOBPvPhYQtJ/DAiy/sjHqwl/vJ0/de7
         40b8TngJVZmug==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 23 Oct 2023 22:59:35 +0300
Message-Id: <CWG330WZCFGQ.35L0OJ29CT08S@suppilovahvero>
To:     <chenguohua@jari.cn>, <dhowells@redhat.com>
Cc:     <keyrings@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] KEYS: Clean up errors in key.h
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.15.2
References: <1f5f72f6.936.18b2322e256.Coremail.chenguohua@jari.cn>
In-Reply-To: <1f5f72f6.936.18b2322e256.Coremail.chenguohua@jari.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Oct 12, 2023 at 12:06 PM EEST,  wrote:
> Fix the following errors reported by checkpatch:
>
> ERROR: space required before the open parenthesis '('
>
> Signed-off-by: GuoHua Cheng <chenguohua@jari.cn>

So what was the patch?

> ---
>  include/linux/key.h | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/include/linux/key.h b/include/linux/key.h
> index 938d7ecfb495..48a43c9efaed 100644
> --- a/include/linux/key.h
> +++ b/include/linux/key.h
> @@ -503,18 +503,18 @@ extern void key_init(void);
>  #define key_validate(k)			0
>  #define key_serial(k)			0
>  #define key_get(k) 			({ NULL; })
> -#define key_revoke(k)			do { } while(0)
> -#define key_invalidate(k)		do { } while(0)
> -#define key_put(k)			do { } while(0)
> -#define key_ref_put(k)			do { } while(0)
> +#define key_revoke(k)			do { } while (0)
> +#define key_invalidate(k)		do { } while (0)
> +#define key_put(k)			do { } while (0)
> +#define key_ref_put(k)			do { } while (0)
>  #define make_key_ref(k, p)		NULL
>  #define key_ref_to_ptr(k)		NULL
>  #define is_key_possessed(k)		0
> -#define key_fsuid_changed(c)		do { } while(0)
> -#define key_fsgid_changed(c)		do { } while(0)
> -#define key_init()			do { } while(0)
> -#define key_free_user_ns(ns)		do { } while(0)
> -#define key_remove_domain(d)		do { } while(0)
> +#define key_fsuid_changed(c)		do { } while (0)
> +#define key_fsgid_changed(c)		do { } while (0)
> +#define key_init()			do { } while (0)
> +#define key_free_user_ns(ns)		do { } while (0)
> +#define key_remove_domain(d)		do { } while (0)
> =20
>  #endif /* CONFIG_KEYS */
>  #endif /* __KERNEL__ */

BR, Jarkko

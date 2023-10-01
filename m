Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50E197B4903
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 20:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235269AbjJASED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 14:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233932AbjJASEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 14:04:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC7EBC
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 11:04:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44CECC433C7;
        Sun,  1 Oct 2023 18:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696183437;
        bh=ZodjcWfhxOXnDQ1eehS6Akzx8Yb+22bfAhpsgF2YlNw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ScVpDHQ8Jz5VoCJN1eXnl/YrmFB0H3ONS5hD0IWF2PCkJd+6lHhbBEmdXXsqdt+AK
         lasPuqgThLunmpBEshae4Kz2pmLIKWqJM7LqF4sd6oLduXxyueI+ZakVFvcDxKVsjA
         vw0pAFMK03VOXyxF/53AJd8oVNLTW12kNAnY7/E+J3oQ9PBrzkb36gkpOI4TlidXdf
         BQKzuvrKxMPRGzr+WPma+tEJTfISoCnfAnyo7c+bzFNZnAB5TfWTmPlN/rHnLZavc1
         Pe8qu+3OtlUAxul7Iqc3p7gAqk5Q8+b5pBEsPgh/6IKDg6Vl0Mv8uU6ZcvxyxrC4+0
         obYNcQISBDgYw==
Date:   Sun, 1 Oct 2023 20:03:53 +0200
From:   Simon Horman <horms@kernel.org>
To:     chenguohua@jari.cn
Cc:     edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netdev: Clean up errors in netdevice.h
Message-ID: <20231001180353.GU92317@kernel.org>
References: <2de2b453.859.18ad4b697c8.Coremail.chenguohua@jari.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2de2b453.859.18ad4b697c8.Coremail.chenguohua@jari.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 11:37:30AM +0800, chenguohua@jari.cn wrote:
> Fix the following errors reported by checkpatch:
> 
> ERROR: that open brace { should be on the previous line
> ERROR: spaces required around that '=' (ctx:VxV)
> 
> Signed-off-by: GuoHua Cheng <chenguohua@jari.cn>

Hi GuoHua Cheng,

I'm sorry, but checkpatch cleanup patches for Networking code
are not accepted.

pw-bot: rejected

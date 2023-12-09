Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 794C580B0EB
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 01:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234262AbjLIAYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 19:24:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjLIAYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 19:24:42 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944C5172A;
        Fri,  8 Dec 2023 16:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=+Bla+2D/SmF77m+DIEiC5p/+uiJpt3KbwhPpcNnWVmQ=; b=LtCdjgIR9u3vR7VjCKN9E0TxGU
        LynRo1fqak3yHiqC1RGbnc9nW52U5I+pjiT5QWqNmMctDBx8FBcevYk6rx602TVPZxEYvAKD2wxgn
        /GTE0yNx4XAYFca4oiZL2H6IKE+bhIjvIQ4AxgDhs1Z6caShufvSzHAhYUCUnzaS6zgYYNMXGrkgn
        zaxdrx5wL7E7TNR93x9ZeF0xUpkvw0xGAS9V8lnEELhzKVOPVXot38f9kgj2tpYmFXubSvVhO/Mfg
        mdzy5uDFmD/M9Nu3HEc/+kjY7XGZyAS+cx0pCen4XhtF0N6OlIt0vtRpe6Lq72PrjoHUSI92D2gBq
        9A3dB8tQ==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1rBl9E-00GopX-1P;
        Sat, 09 Dec 2023 00:24:48 +0000
Message-ID: <9e6c1e79-7728-42b9-b968-2e9d030d1c27@infradead.org>
Date:   Fri, 8 Dec 2023 16:24:48 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] Rework the top-level process page
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <87msuk2pu8.fsf@meer.lwn.net>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <87msuk2pu8.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/8/23 16:15, Jonathan Corbet wrote:
> +Other material
> +--------------
> +
> +Here are some other guides to the community that are of interest to most
> +developers are:

eh?

-- 
~Randy

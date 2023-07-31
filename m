Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4CAC768B24
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 07:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjGaF2N convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 31 Jul 2023 01:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjGaF2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 01:28:10 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307D0E5D;
        Sun, 30 Jul 2023 22:28:08 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 83FD563577C9;
        Mon, 31 Jul 2023 07:27:55 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id G9JFjYMLxIRN; Mon, 31 Jul 2023 07:27:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 550AC63577D4;
        Mon, 31 Jul 2023 07:27:54 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id nipuTvMz7oy1; Mon, 31 Jul 2023 07:27:54 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 2B97763577C9;
        Mon, 31 Jul 2023 07:27:54 +0200 (CEST)
Date:   Mon, 31 Jul 2023 07:27:54 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     masahiroy <masahiroy@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        anton ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um <linux-um@lists.infradead.org>, tj <tj@kernel.org>,
        Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        alsa-devel <alsa-devel@alsa-project.org>
Message-ID: <1063472755.889096.1690781274039.JavaMail.zimbra@nod.at>
In-Reply-To: <3cd0e5b7-7e20-ce3b-e391-eb77443f63b1@infradead.org>
References: <20230728043013.27776-1-rdunlap@infradead.org> <CAK7LNAR4BkAKhZZ8+Zybed3Jm3omxzzdgus-Nqj-9MjWAeSmiA@mail.gmail.com> <3cd0e5b7-7e20-ce3b-e391-eb77443f63b1@infradead.org>
Subject: Re: [PATCH v3] um/drivers: fix hostaudio build errors
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: um/drivers: fix hostaudio build errors
Thread-Index: NkqIAPWFcMLKoL0J2Cdhb+WpEEOx+g==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Randy Dunlap" <rdunlap@infradead.org>
> Oh, good point, and one that I agree with.
> 
> I'll send a v4.

Ok!
 
>> 
>> Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>
> 
> Takashi, I don't know who will merge the patch, but I would expect
> that one of the UML maintainers to merge it.... FWIW.

Yep. I'll carry this fix (v4) through the uml tree.

Thanks,
//richard

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 782717BAF54
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 01:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjJEXbV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 5 Oct 2023 19:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjJEXaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 19:30:23 -0400
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1582D60
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 16:30:21 -0700 (PDT)
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay06.hostedemail.com (Postfix) with ESMTP id 9A689B4523;
        Thu,  5 Oct 2023 23:30:20 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf10.hostedemail.com (Postfix) with ESMTPA id 890902F;
        Thu,  5 Oct 2023 23:30:18 +0000 (UTC)
Message-ID: <9329b4a2c6be3e7d55a7efb2988fd5ecead38c5f.camel@perches.com>
Subject: Re: [PATCH] get_maintainer: add --keywords-in-file option
From:   Joe Perches <joe@perches.com>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 05 Oct 2023 16:30:17 -0700
In-Reply-To: <CAFhGd8q5Tktj4d_Y3Z12xycz_iwwWgVvspUdTGxOYM4M318bsg@mail.gmail.com>
References: <01fe46f0c58aa8baf92156ae2bdccfb2bf0cb48e.camel@perches.com>
         <CAFhGd8q5Tktj4d_Y3Z12xycz_iwwWgVvspUdTGxOYM4M318bsg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 890902F
X-Stat-Signature: naf1fpgnk64ie6zsmio5ona8bdebsn7d
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+tXgppzurkDMF3FTKct7b18HlOU7O4W1U=
X-HE-Tag: 1696548618-341354
X-HE-Meta: U2FsdGVkX1+lUi7+dwGhK618phYzIzr6o9KSCsWfhybAFupt8T3rfIlxFCSlkaE+mfBgByPRz9yDyNXAU9Sh2Mc53vqrb8VjCqJGDDrV4QKFY7eTxX28lke1k97jFbig57LydDQ9MenTZt9hr+r9EoV+7D5fL8CJBu2vlS5WIYSArUynbv84hzwVnbnlg7V3FY7fuxEZFbAvWueDOVtkwAAeuXZOCzmvtxCKRXQ6m4qyk6dLk1OLf6BtV5gSFp9xc1i+GewRVRkLRl7GNgrdvBcDmGOmzukuKASFvpYJ78al8TydsPiMykvsT/nVqlbN+pXMz5U+xGw2MgZ6Cbbv6a/iM7WgxDfT1bfkh3HU25QtDxyW0HzxsraUbNic5BQVsM3dW5Xs6Ecdj79jXUvxlw==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-10-05 at 15:00 -0700, Justin Stitt wrote:
> On Thu, Oct 5, 2023 at 2:35 PM Joe Perches <joe@perches.com> wrote:
[trivial patch]
> 
> Works great!
> 
> Some inboxes/lists should now be a little less noisy.
> 
> Tested-by: Justin Stitt <justinstitt@google.com>

Thanks for pushing it forward.

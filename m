Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 457527A4ED7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 18:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjIRQ1w convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 18 Sep 2023 12:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjIRQ1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 12:27:32 -0400
X-Greylist: delayed 137 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 18 Sep 2023 09:25:11 PDT
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2100A2F2F9;
        Mon, 18 Sep 2023 09:25:10 -0700 (PDT)
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay07.hostedemail.com (Postfix) with ESMTP id C6BC91601B4;
        Mon, 18 Sep 2023 16:25:08 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf08.hostedemail.com (Postfix) with ESMTPA id 64FDD2002C;
        Mon, 18 Sep 2023 16:25:06 +0000 (UTC)
Message-ID: <0dc5f16bf252a86dfb74649493311763780b641a.camel@perches.com>
Subject: Re: [PATCH v2] platform/x86: think-lmi: Add bulk save feature
From:   Joe Perches <joe@perches.com>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Mark Pearson <mpearson-lenovo@squebb.ca>
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 18 Sep 2023 09:25:05 -0700
In-Reply-To: <ZQhX6Ynz-cl1gkNu@smile.fi.intel.com>
References: <mpearson-lenovo@squebb.ca>
         <20230906121328.50437-1-mpearson-lenovo@squebb.ca>
         <ZQhXZkBHviGOEl-x@smile.fi.intel.com> <ZQhX6Ynz-cl1gkNu@smile.fi.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: 64FDD2002C
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Stat-Signature: 9y3ss9zngu6xyc1dft7aa9ycpzeqey5f
X-Rspamd-Server: rspamout08
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/j0U92jOb2J7H1At4KRVyZrzDskRdxT38=
X-HE-Tag: 1695054306-681852
X-HE-Meta: U2FsdGVkX18lb71DJPStYJ49sE4KmU2d92msDJEfCWF6jffR0htH8BJa4yOgGAT5eu2uWwqBPr+6L29c2Mdfrf60DL1daios6f1Xi3GOVEKcVkGNfGf4s2AvV0OC8ygRD8JB3gCZrhVz3b0oqd6+0aPAZpXq0Nv+Q0p1G7SHmcRAHmxg0aGcA48DSBAS1AqjK+KhOP4C/p+IukWcrsgy/ExaGW3mOGBlhP4p4rLY+AA8AhqMM9JxrTDeAY5kKnww8iS+p+70CiVD6EmxMGXwcO35GPCGz3p2LWLKqtEh3QImWwyXnspVcG17Ss/lGT/S
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-09-18 at 17:00 +0300, Andy Shevchenko wrote:
> On Mon, Sep 18, 2023 at 04:57:58PM +0300, Andy Shevchenko wrote:
> > On Wed, Sep 06, 2023 at 08:13:14AM -0400, Mark Pearson wrote:
> 
> ...
> 
> > > +Date:		August 2023
> > > +KernelVersion:	6.5
> > 
> > This is obviously incorrect (outdated) information.
> 
> Joe, does checkpatch have a hook to test that (using phb-crystal-ball data)?

No and I rather doubt it should.

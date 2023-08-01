Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE8876B5A6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 15:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234031AbjHANUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 09:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234028AbjHANT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 09:19:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F334E1718;
        Tue,  1 Aug 2023 06:19:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4430B61593;
        Tue,  1 Aug 2023 13:19:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21E7FC433C8;
        Tue,  1 Aug 2023 13:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690895994;
        bh=N16kUGbShWqhxLvSawj93d4JF8F26wcnu1V7ivdossI=;
        h=Date:To:Cc:From:Subject:From;
        b=DSxLk6mxm0Nfwf33w1D9tcbtQ2W7YGpDo/uW0zQIecHR9ayhVUuw1o4l3M7mm18H3
         nOoIGr5WxDq4QsdPlWoT4TSdAcAYeUT4WCUP0XsYzWFjww4Zp93FIgKSYoYBZOu9Ev
         KPsEpXN3GE/MqQvMnzcu0eNqteZt7HF1or5HGFuuA2MoBpyU6ZEXM9AIvz91L3x0mq
         6vKM/Fj8BH0MAXukLOxOixCma0qn85tMMTDqVm2ipVFllIbBhG8XvdS2wBJZyn8uLi
         2fyZpbFYJcGWBrKya2COo6SOFXdEljG2zssJsW/qrNzlm5EyveZvH/Pc8TTNCkOiVd
         4A83Paq55grMA==
Message-ID: <9d2898a0-239a-1bc7-4929-aa042f727ff4@kernel.org>
Date:   Tue, 1 Aug 2023 15:19:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Content-Language: en-US
To:     linux-man <linux-man@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        GNU C Library <libc-alpha@sourceware.org>,
        Sam James <sam@gentoo.org>, Jonathan Corbet <corbet@lwn.net>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Marcos Fouces <marcos@debian.org>
From:   Alejandro Colomar <alx@kernel.org>
Subject: man-pages-6.05 released
Organization: Linux
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------OJ6ygR6T20mppHxcM1rmpPGa"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------OJ6ygR6T20mppHxcM1rmpPGa
Content-Type: multipart/mixed; boundary="------------NeRYs80ZywTIsA1DwnVbu4GZ";
 protected-headers="v1"
From: Alejandro Colomar <alx@kernel.org>
To: linux-man <linux-man@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 GNU C Library <libc-alpha@sourceware.org>, Sam James <sam@gentoo.org>,
 Jonathan Corbet <corbet@lwn.net>, Michael Kerrisk <mtk.manpages@gmail.com>,
 Marcos Fouces <marcos@debian.org>
Message-ID: <9d2898a0-239a-1bc7-4929-aa042f727ff4@kernel.org>
Subject: man-pages-6.05 released

--------------NeRYs80ZywTIsA1DwnVbu4GZ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gidday!

I'm proud to announce:

	man-pages-6.05 - manual pages for GNU/Linux

The release tarball is already available at <kernel.org>

Tarball download:
	<https://mirrors.edge.kernel.org/pub/linux/docs/man-pages/>
Git repository:
	<https://git.kernel.org/cgit/docs/man-pages/man-pages.git/>

A change from man-pages-6.04 merits a mention in this release, as it
wasn't properly documented in the previous release notes:

   -  Add make(1) 'check' target.  This has been split from 'lint'.
      'lint' will check the source code, and 'check' will check the
      rendered pages (as a user will read them).  There are currently
      several pages that fail this `make check`, and distributors that
      depend on this can workaround it by touching a few files:

      $ make check -k -j >/dev/null 2>/dev/null;
      $ make check -k 2>/dev/null;
      GREP      .tmp/man/man1/memusage.1.check-catman.touch
      TROFF     .tmp/man/man2/fanotify_init.2.cat.set
      TROFF     .tmp/man/man2/gettimeofday.2.cat.set
      TROFF     .tmp/man/man2/s390_sthyi.2.cat.set
      GREP      .tmp/man/man3/mallopt.3.check-catman.touch
      TROFF     .tmp/man/man3/unlocked_stdio.3.cat.set
      TROFF     .tmp/man/man4/console_codes.4.cat.set
      TROFF     .tmp/man/man4/lirc.4.cat.set
      GREP      .tmp/man/man4/smartpqi.4.check-catman.touch
      GREP      .tmp/man/man4/veth.4.check-catman.touch
      TROFF     .tmp/man/man5/proc.5.cat.set
      GREP      .tmp/man/man5/slabinfo.5.check-catman.touch
      TROFF     .tmp/man/man5/tzfile.5.cat.set
      TROFF     .tmp/man/man7/address_families.7.cat.set
      TROFF     .tmp/man/man7/ascii.7.cat.set
      TROFF     .tmp/man/man7/bpf-helpers.7.cat.set
      GREP      .tmp/man/man7/keyrings.7.check-catman.touch
      GREP      .tmp/man/man7/uri.7.check-catman.touch
      TROFF     .tmp/man/man8/tzselect.8.cat.set
      TROFF     .tmp/man/man8/zdump.8.cat.set
      TROFF     .tmp/man/man8/zic.8.cat.set

      After touching the previous files, `make check` will succeed:

      $ make check -k 2>/dev/null | awk '{print $2}' | xargs touch;
      $ make check -j >/dev/null;
      $ echo $?
      0

The most notable changes in this release (man-pages-6.05) are:

New and rewritten pages
-----------------------

man2/
        ioctl_pipe.2

man3/
        regex.3

man5/
        erofs.5

Newly documented interfaces in existing pages
---------------------------------------------

bpf.2
        EAGAIN

ioctl_userfaultfd.2
        UFFD_FEATURE_EXACT_ADDRESS

prctl.2
        PR_GET_AUXV

recv.2
        MSG_CMSG_CLOEXEC

statx.2
        STAT_ATTR_MOUNT_ROOT

syscall.2
        ENOSYS

resolv.conf.5
        no-aaaa
        RES_NOAAAA

tmpfs.5
        CONFIG_TRANSPARENT_HUGEPAGE

ip.7
        IP_LOCAL_PORT_RANGE

rtnetlink.7
        IFLA_PERM_ADDRESS

New and changed links
---------------------

man3type/
        regex_t.3type                           (regex(3))
        regmatch_t.3type                        (regex(3))
        regoff_t.3type                          (regex(3))

Global changes
--------------

-  Types:
   -  Document functions using off64_t as if they used off_t (except
      for lseek64()).

-  Build system:
   -  Keep file modes in the release tarball.
   -  Fix symlink installation (`make install LINK_PAGES=3Dsymlink`).
   -  Add support for using bzip2(1), lzip(1), and xz(1) when installing
      pages and creating release tarballs.
   -  Create reproducible release tarballs.
   -  Move makefiles from lib/ to share/mk/.
   -  Support mdoc(7) pages.
   -  Relicense Makefiles as GPL-3.0-or-later.
   -  Build PostScript and PDF manual pages.
   -  Add support for running our build system on arbitrary source
      trees; this makes it possible to easily run our linters on another
      project's manual pages as easily as `make lint MANDIR=3D~/src/groff=
`

-  Licenses:
   -  Relicense ddp.7 from VERBATIM_ONE_PARA to Linux-man-pages-copyleft.=

   -  Relicense dir_colors.5 from LDPv1 to GPL-2.0-or-later.
   -  Use new SPDX license identifiers:
      -  Linux-man-pages-1-para                 (was VERBATIM_ONE_PARA)
      -  Linux-man-pages-copyleft-2-para        (was VERBATIM_TWO_PARA)
      -  Linux-man-pages-copyleft-var           (was VERBATIM_PROF)

-  ffix:
   -  use `\%`
   -  un-bracket tbl(1) tables


Contributors
------------

The following people contributed patches/fixes, reports, notes,
ideas, and discussions that have been incorporated in changes in
this release:

"David S. Miller" <davem@davemloft.net>
"G. Branden Robinson" <g.branden.robinson@gmail.com>
A. Wilcox <AWilcox@wilcox-tech.com>
Adam Dobes <adobes@redhat.com>
Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
Alan Cox <alan@llwyncelyn.cymru>
Alejandro Colomar <alx@kernel.org>
Alexei Starovoitov <ast@kernel.org>
Andreas Schwab <schwab@suse.de>
Andrew Clayton <andrew@digital-domain.net>
Andrew Morton <akpm@linux-foundation.org>
Avinesh Kumar <akumar@suse.de>
Bastien Roucari=C3=A8s <rouca@debian.org>
Bjarni Ingi Gislason <bjarniig@simnet.is>
Brian Inglis <Brian.Inglis@Shaw.ca>
Bruno Haible <bruno@clisp.org>
Carsten Grohmann <carstengrohmann@gmx.de>
Colin Watson <cjwatson@debian.org>
Cyril Hrubis <chrubis@suse.cz>
DJ Delorie <dj@redhat.com>
Daniel Verkamp <daniel@drv.nu>
David Howells <dhowells@redhat.com>
Dirk Gouders <dirk@gouders.net>
Dmitry Goncharov <dgoncharov@users.sf.net>
Eli Zaretskii <eliz@gnu.org>
Elliott Hughes <enh@google.com>
Eric Biggers <ebiggers@google.com>
Eric Blake <eblake@redhat.com>
Eric Wong <e@80x24.org>
Fangrui Song <maskray@google.com>
Florian Weimer <fweimer@redhat.com>
Gavin Smith <gavinsmith0123@gmail.com>
Guillem Jover <guillem@hadrons.org>
G=C3=BCnther Noack <gnoack@google.com>
Helge Kreutzmann <debian@helgefjell.de>
Igor Sysoev <igor@sysoev.ru>
Ingo Schwarze <schwarze@openbsd.org>
Jakub Jelinek <jakub@redhat.com>
Jakub Sitnicki <jakub@cloudflare.com>
Jakub Wilk <jwilk@jwilk.net>
Johannes Weiner <hannes@cmpxchg.org>
John Gilmore <gnu@toad.com>
John Hubbard <jhubbard@nvidia.com>
John Scott <jscott@posteo.net>
Jonathan Corbet <corbet@lwn.net>
Jonathan Wakely <jwakely@redhat.com>
Joseph Myers <joseph@codesourcery.com>
Josh Triplett <josh@joshtriplett.org>
Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Larry McVoy <lm@mcvoy.com>
Lennart Jablonka <humm@ljabl.com>
Linus Heckemann <git@sphalerite.org>
Lukas Javorsky <ljavorsk@redhat.com>
Marcos Fouces <marcos@debian.org>
Mario Blaettermann <mario.blaettermann@gmail.com>
Martin (Joey) Schulze <joey@infodrom.org>
Masami Hiramatsu <mhiramat@kernel.org>
Masatake YAMATO <yamato@redhat.com>
Matthew House <mattlloydhouse@gmail.com>
Matthew Wilcox (Oracle) <willy@infradead.org>
Michael Kerrisk <mtk.manpages@gmail.com>
Michael Wei=C3=9F <michael.weiss@aisec.fraunhofer.de>
Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
Mike Frysinger <vapier@gentoo.org>
Mike Kravetz <mike.kravetz@oracle.com>
Mingye Wang <arthur200126@gmail.com>
Nadav Amit <namit@vmware.com>
Nick Desaulniers <ndesaulniers@google.com>
Oskari Pirhonen <xxc3ncoredxx@gmail.com>
Paul E. McKenney <paulmck@kernel.org>
Paul Eggert <eggert@cs.ucla.edu>
Paul Floyd <pjfloyd@wanadoo.fr>
Paul Smith <psmith@gnu.org>
Philip Guenther <guenther@gmail.com>
Ralph Corderoy <ralph@inputplus.co.uk>
Reuben Thomas <rrt@sc3d.org>
Rich Felker <dalias@libc.org>
Richard Biener <richard.guenther@gmail.com>
Sam James <sam@gentoo.org>
Serge Hallyn <serge@hallyn.com>
Seth David Schoen <schoen@loyalty.org>
Siddhesh Poyarekar <siddhesh@gotplt.org>
Simon Horman <simon.horman@corigine.com>
Stefan Puiu <stefan.puiu@gmail.com>
Steffen Nurpmeso <steffen@sdaoden.eu>
Szabolcs Nagy <nsz@port70.net>
Thomas Wei=C3=9Fschuh <thomas@t-8ch.de>
Tom Schwindl <schwindl@posteo.de>
Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
Torbjorn SVENSSON <torbjorn.svensson@foss.st.com>
Ulrich Drepper <drepper@redhat.com>
Vahid Noormofidi <vnoormof@nvidia.com>
Vlastimil Babka <vbabka@suse.cz>
Wilco Dijkstra <Wilco.Dijkstra@arm.com>
Xi Ruoyao <xry111@xry111.site>
Yang Xu <xuyang2018.jy@fujitsu.com>
Yedidyah Bar David <didi@redhat.com>
Zack Weinberg <zack@owlfolio.org>
Zijun Zhao <zijunzhao@google.com>

Apologies if I missed anyone!


Thanks you all for contributing!

Cheers,
Alex

--=20
<http://www.alejandro-colomar.es/>
GPG key fingerprint: A9348594CE31283A826FBDD8D57633D441E25BB5

--------------NeRYs80ZywTIsA1DwnVbu4GZ--

--------------OJ6ygR6T20mppHxcM1rmpPGa
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmTJBmAACgkQnowa+77/
2zJ5pg/9GXqOqVeUVg/5Dottyq/6doDFmC98o/MsQmSDeTzp58dMspAsgoVh98Je
JITRorXejhfyymKk2RT1utukCagBW1GxJyTRKJUrhKj1ChVMEz5qslzGzPZpbIFB
lXB3Xl+lV3OiFmPytPnIripfTVcUETYcxJEo0iZV9FRinsXTQDtEHYeyIAhbiT+4
PGVcmD3n2YDfLLe/l7Xci3moPSjz5IV3UOY5xwYDVetz6mMPpf1NyqojNTfh7Y1X
105lg2ofuJltMP1nezmmaD5FWhAKO694Xc7Qk3dlWz7QFWt6yK5lR2HJYtN+VnON
IJ/OG1sz94rfLAs+Z8lChqT4rkJepOX6iIxcHZL/RY+SJmNXd6OStUgRAF3TFD/5
r6uDjXNwFvTFd1xTPOXXeZ/ii88TGg6rItv+eIV9UIGE0dQUT8w3Eatq/RWKZwDR
xUm0/9RDuzGSPjTxsaeWw/n/Jj66nhiZa2GQyn8BSnGqmho6675UKdWVUX99p6rc
a6Qn8PIAGlQC/vDIne9X+29nJvH0M3W7f/eh6oLkvCfQdbpjsgZ0E+1/dgvUIPbN
h1DNdtHfAYHg7eqaDKdzGZjvUmOSrcxkXhdP0kYm4wRX015JRhK3uH7aWzdFo2Kd
0OvN0o4suJqC34PK+YLLbuyULAR4nQttgmu90UqKAOAUGNmi3xY=
=dJ5n
-----END PGP SIGNATURE-----

--------------OJ6ygR6T20mppHxcM1rmpPGa--
